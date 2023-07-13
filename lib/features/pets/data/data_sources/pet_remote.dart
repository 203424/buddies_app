import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buddies_app/features/pets/data/models/pet/pet_model.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

String apiURL = '54.147.179.0';

abstract class PetRemoteDataSource {
  Future<List<PetModel>> getPets();
  Future<List<PetModel>> getPetsById( int petid);

  Future<List<PetModel>> createPet(PetEntity pet);
  Future<List<PetModel>> updatePet(PetEntity pet, int petid);
  Future<List<PetModel>> deletePet(int petid);
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {


  @override
  Future<List<PetModel>> createPet(PetEntity pet) async {
    var url = Uri.https(apiURL, '/api/pets/post');
    var headers = {'Content-Type': 'application/json'};
    List<Map<String, dynamic>> body = [];

      var object = {
        'owner_id': pet.owner_id,
        'name': pet.name,
        'description': pet.description,
        'breed': pet.breed,
        'type': pet.type,
        'birthday': pet.birthday,
        'gender': pet.gender,
        'size': pet.size,
      };
      body.add(object);

    var response = await http.post(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve una lista de PetModel
      List<dynamic> responseData = convert.jsonDecode(response.body);
      List<PetModel> petModels = responseData.map((data) => PetModel.fromJson(data)).toList();
      return petModels;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al crear la mascota');
    }
  }


  @override
  Future<List<PetModel>> deletePet(int petid) async {
    var url = Uri.https(apiURL, '/api/tareas/$petid');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.delete(url, headers: headers);

    if (response.statusCode == 200) {
      // Si la solicitud de eliminación fue exitosa, puedes devolver una lista vacía o cualquier otro resultado deseado.
      return [];
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera.
      throw Exception('Error al eliminar la mascota');
    }
  }

  @override
  Future<List<PetModel>> getPets() async {
    var url = Uri.http(apiURL, '/api/pets/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var dataPets = convert
          .jsonDecode(response.body)
          .map<PetModel>((data) => PetModel.fromJson(data))
          .toList();
      print(dataPets);

      return dataPets;
    } else {
      throw Exception('Error');
    }
  }
  @override
  Future<List<PetModel>> getPetsById(int petid) async {
    var url = Uri.https(apiURL, '/api/tareas/$petid');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve una lista con la mascota encontrada
      dynamic responseData = convert.jsonDecode(response.body);
      PetModel pet = PetModel.fromJson(responseData);
      return [pet];
    } else if (response.statusCode == 404) {
      // Si la mascota no fue encontrada, devuelve una lista vacía
      return [];
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al obtener la mascota');
    }
  }

  @override
  Future<List<PetModel>> updatePet(PetEntity pet, int petid) async {
    var url = Uri.https(apiURL, '/api/tareas/$petid');
    var headers = {'Content-Type': 'application/json'};

    List<Map<String, dynamic>> body = [];

    var object = {
      'name': pet.name,
      'description': pet.description,
      'breed': pet.breed,
      'type': pet.type,
      'birthday': pet.birthday,
      'gender': pet.gender,
      'size': pet.size,
    };
    body.add(object);

    var response = await http.put(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve una lista de PetModel
      List<dynamic> responseData = convert.jsonDecode(response.body);
      List<PetModel> petModels = responseData.map((data) => PetModel.fromJson(data)).toList();
      return petModels;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al actualizar la mascota');
    }
  }





}
