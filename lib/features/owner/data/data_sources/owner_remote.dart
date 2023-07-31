import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:buddies_app/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buddies_app/features/owner/data/models/owner_model.dart';
import '../../domain/entities/owner_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiURL = Config.apiURL;

abstract class OwnerRemoteDataSource {
  Future<OwnerModel> createOwner(OwnerEntity owner);
  Future<List<OwnerModel>> updateOwner(OwnerEntity owner);
  Future<void> deleteOwner(int ownerid);
  Future<OwnerModel> getOwnerById(int ownerid);
  Future<OwnerModel> signIn(String email, String password);
  Future<void> logOut();
}

class OwnerRemoteDataSourceImpl implements OwnerRemoteDataSource {
  @override
  Future<OwnerModel> createOwner(OwnerEntity owner) async {
    var response;
    var url = Uri.http(apiURL, '/api/owners/');
    var headers = {'Content-Type': 'application/json'};

    var body = {
      'name': owner.name,
      'email': owner.email,
      'password': owner.password,
    };
    response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 201) {
      var responseData = convert.jsonDecode(response.body);
      print(responseData['email']);
      var ownerModel = OwnerModel.fromJson(responseData);
      return ownerModel;
    } else {
      throw Exception('Error al registrar usuario');
    }
  }

  @override
  Future<void> deleteOwner(int ownerid) async {
    final url = Uri.http(apiURL, '/api/owners/$ownerid');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la mascota');
    }
  }

  @override
  Future<OwnerModel> signIn(String email, String password) async {
    final url = Uri.http(apiURL, '/api/owners/signIn/');
    final headers = {'Content-Type': 'application/json'};
    final body = {
      'email': email,
      'password': password,
    };
    print(email + " " + password);

    final response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      final responseData = convert.jsonDecode(response.body);
      Map<String, dynamic> jwtDecodedToken =
          JwtDecoder.decode(responseData['token']);
      await prefs.setString('token', responseData['token']);
      await prefs.setInt('id', jwtDecodedToken['id']);
      print("jwt recibido: ${responseData['token']}\ndatos: $jwtDecodedToken");
      final ownerModel = OwnerModel.fromJson(responseData);
      return ownerModel;
    } else {
      throw Exception('Credenciales incorrectas');
    }
  }

  @override
  Future<OwnerModel> getOwnerById(int ownerid) async {
    final url = Uri.http(apiURL, '/api/owners/$ownerid');
    final headers = {'Content-Type': 'application/json'};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      final ownerModel = OwnerModel.fromJson(responseData);
      return ownerModel;
    } else {
      throw Exception('Error al obtener el dueño por ID');
    }
  }

  @override
  Future<void> logOut() async {
    final url = Uri.http(apiURL, '/api/logout');
    final headers = {'Content-Type': 'application/json'};

    // Si estás utilizando un token de autenticación en la API, puedes enviar una solicitud para invalidar el token aquí.
    // Por ejemplo, puedes enviar una solicitud POST con el token actual a un endpoint de logout.

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, puedes limpiar cualquier información de autenticación almacenada localmente en la aplicación.
      // Por ejemplo, puedes eliminar el token o cualquier otra información relacionada con la sesión del usuario.

      // Opcionalmente, puedes realizar otras operaciones relacionadas con el cierre de sesión aquí, como navegar a la pantalla de inicio de sesión.
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera.
      throw Exception('Error al cerrar sesión');
    }
  }

  @override
  Future<List<OwnerModel>> updateOwner(OwnerEntity owner) async {
    var url = Uri.http(apiURL,
        '/api/pets/$owner.id'); // Asegurarse de incluir el id de la mascota en la ruta
    var headers = {'Content-Type': 'application/json'};

    var body = {
      'id': owner.id,
      'name': owner.name,
      'email': owner.email,
      'password': owner.password,
    };

    var response =
        await http.put(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve una lista de PetModel
      List<dynamic> responseData = convert.jsonDecode(response.body);
      List<OwnerModel> ownerModels =
          responseData.map((data) => OwnerModel.fromJson(data)).toList();
      return ownerModels;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al actualizar la mascota');
    }
  }
}
