import 'dart:convert';

import 'package:buddies_app/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buddies_app/features/pets/data/models/pet/pet_model.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

String apiURL = Config.apiURL;

abstract class PetRemoteDataSource {
  Future<List<PetModel>> getPetsById(List<int> petsId);
  Future<List<PetModel>> getPetsByUserId(int id);
  Future<List<PetModel>> createPet(List<PetEntity> pets);
  Future<List<PetModel>> updatePet(List<PetEntity> pets, List<int> petIds);
  Future<void> deletePet(int petid);
}

class PetRemoteDataSourceImpl implements PetRemoteDataSource {
  @override
  Future<List<PetModel>> createPet(List<PetEntity> pets) async {
    var url = Uri.http(apiURL, '/api/pets/');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = pets
        .map((pet) => {
              'id': pet.id,
              'name': pet.name,
              'birthday': pet.birthday,
              'type': pet.type,
              'breed': pet.breed,
              'gender': pet.gender,
              'size': pet.size,
              'description': pet.description,
              'owner_id': pet.owner_id,
            })
        .toList();
    var response =
        await http.post(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 201) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve un objeto PetModel
      var responseData = convert.jsonDecode(response.body);
      var petModels = List<PetModel>.from(
          responseData.map((data) => PetModel.fromJson(data)));
      return petModels;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al crear la mascota');
    }
  }

  Future<String?> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<void> deletePet(int petId) async {
    String petsIdJson = jsonEncode(petId);
    String escapedPetsIdJson = Uri.encodeQueryComponent(petsIdJson);
    var url = Uri.http(apiURL, "/api/pets/", {"array": escapedPetsIdJson});
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    print(http.get(url, headers: headers));

    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la mascota');
    }
  }

  @override
  Future<List<PetModel>> getPetsByUserId(int id) async {
    var url = Uri.http(apiURL, '/api/pets/getByUserId/$id');
    final String? token = await getTokenFromSharedPreferences();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);

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
    String petsIdJson = jsonEncode(petsId);
    String escapedPetsIdJson = Uri.encodeQueryComponent(petsIdJson);

    var url = Uri.http(
        apiURL, "/api/pets/getByIdMultiple", {"array": escapedPetsIdJson});
    final String? token = await getTokenFromSharedPreferences();
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      
      dynamic responseData = convert.jsonDecode(response.body);
      PetModel pet = PetModel.fromJson(responseData);
      return [pet];
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Error al obtener la mascota');
    }
  }

  @override
  Future<List<PetModel>> updatePet(
      List<PetEntity> pets, List<int> petIds) async {
    String petsIdJson = jsonEncode(petIds);
    String escapedPetsIdJson = Uri.encodeQueryComponent(petsIdJson);
    var url = Uri.http(apiURL, "/api/pets/", {"array": escapedPetsIdJson});
    print(url);
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = pets
        .map((pet) => {
              'id': pet.id,
              'name': pet.name,
              'birthday': pet.birthday,
              'type': pet.type,
              'breed': pet.breed,
              'gender': pet.gender,
              'size': pet.size,
              'description': pet.description,
              'owner_id': pet.owner_id,
            })
        .toList();

    var response =
        await http.put(url, body: convert.jsonEncode(body), headers: headers);
    print(response.body);

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve un objeto PetModel
      var responseData = convert.jsonDecode(response.body);
      var petModels = List<PetModel>.from(
          responseData.map((data) => PetModel.fromJson(data)));
      return petModels;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al actualizar la mascota');
    }
  }
}
