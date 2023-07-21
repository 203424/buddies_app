import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buddies_app/features/pets/data/models/pet/pet_model.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

String apiURL = '3.130.221.228';

abstract class PetRemoteDataSource {
  Future<List<PetModel>> getPets();
  Future<List<PetModel>> getPetsById( List<int> petsId);

  Future<PetModel> createPet(PetEntity pet);
  Future<PetModel> updatePet(PetEntity pet, int petid);
  Future<void>deletePet(int petid);
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {


  @override
  Future<PetModel> createPet(PetEntity pet) async {
    var url = Uri.http(apiURL, '/api/pets/');
    var headers = {'Content-Type': 'application/json'};
    var body = {
      'name': pet.name,
      'birthday': pet.birthday,
      'type': pet.type,
      'breed': pet.breed,
      'gender': pet.gender,
      'size': pet.size,
      'description': pet.description,
      'owner_id': pet.owner_id,
    };
    var response = await http.post(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 201) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve un objeto PetModel
      var responseData = convert.jsonDecode(response.body);
      var petModel = PetModel.fromJson(responseData);
      return petModel;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al crear la mascota');
    }
  }


  @override
  Future<void> deletePet(int petId) async {
    final url = Uri.http(apiURL, '/api/pets/');
    final headers = {'Content-Type': 'petId'};

    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
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
      return dataPets;
    } else {
      throw Exception('Error');
    }
  }
  @override
  Future<List<PetModel>> getPetsById(List<int> petsId) async {
    // Formatear la lista de identificadores como una cadena JSON
    String petsIdJson = jsonEncode(petsId);
    // Escapar la cadena JSON para que se transmita correctamente en la URL
    String escapedPetsIdJson = Uri.encodeQueryComponent(petsIdJson);

    // Construir la URL con los parámetros correctamente formateados
    var url = Uri.https(apiURL, "/api/pets/getByIdMultiple", {"array": escapedPetsIdJson});
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

  Future<PetModel> updatePet(PetEntity pet, int petId) async {
    var url = Uri.http(apiURL, '/api/pets/$petId'); // Asegurarse de incluir el id de la mascota en la ruta
    var headers = {'Content-Type': 'application/json'};

    var body = {
      'name': pet.name,
      'description': pet.description,
      'breed': pet.breed,
      'type': pet.type,
      'birthday': pet.birthday,
      'gender': pet.gender,
      'size': pet.size,
    };

    var response = await http.put(url, body: convert.jsonEncode(body), headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve un objeto PetModel
      var responseData = convert.jsonDecode(response.body);
      var petModel = PetModel.fromJson(responseData);
      return petModel;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al actualizar la mascota');
    }
  }




}
