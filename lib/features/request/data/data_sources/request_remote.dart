
import 'package:buddies_app/const.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buddies_app/features/request/data/models/request/request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/request/request_entity.dart';

String apiURL = Config.apiURL;

abstract class RequestRemoteDataSource {
  Future<RequestModel> createRequest(RequestEntity request);
  Future<RequestModel> updateRequest(RequestEntity request);
  Future<void> deleteRequest(int id);
  Future<RequestModel> getById(int id);
  Future<List<RequestModel>> getByUserId(int id);
  Future<List<RequestModel>> getAllRequests();
  Future<List<RequestModel>> getByStatus(String status);
  Future<List<RequestModel>> getInProgress(int userId);
  Future<List<RequestModel>> getHistory(int userId);
  Future<List<RequestModel>> getByCaretakerId(int caretakerId);

}

class RequestRemoteDataSourceImpl implements RequestRemoteDataSource
{
  @override
  Future<RequestModel> createRequest(RequestEntity request) async {
    var url = Uri.http(apiURL, '/api/requests/');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = {
      'id': request.id,
      'type': request.type,
      'start_date': request.start_date,
      'end_date': request.end_date,
      'hour': request.hour,
      'duration': request.duration,
      'location': request.location,
      'cost': request.cost,
      'status': request.status,
      'pet_id': request.pet_id,
      'user_id': request.user_id,
      'caretaker_id': request.caretaker_id,
    };
    var response = await http.post(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 201) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve un objeto PetModel
      var responseData = convert.jsonDecode(response.body);
      var requestModel = RequestModel.fromJson(responseData);
      return requestModel;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al crear la request');
    }
  }

  @override
  Future<void> deleteRequest(int id) async {
    final url = Uri.http(apiURL, '/api/requests/$id');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar la request');
    }
  }

  Future<String?> getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }



  @override
  Future<List<RequestModel>> getAllRequests() async {

    final url = Uri.http(apiURL, '/api/requests');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      final List<RequestModel> requestModels = (responseData as List)
          .map((data) => RequestModel.fromJson(data))
          .toList();
      return requestModels;
    } else {
      throw Exception('Error al obtener las solicitudes');
    }
  }

  @override
  Future<List<RequestModel>> getByCaretakerId(int caretakerId) async {
    final url = Uri.http(apiURL, '/api/requests/$caretakerId');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      // Aquí asumimos que responseData es una lista de objetos RequestModel
      final List<RequestModel> requestModels = (responseData as List)
          .map((data) => RequestModel.fromJson(data))
          .toList();
      return requestModels;
    } else {
      throw Exception('Error al obtener el dueño por ID');
    }
  }

  @override
  Future<RequestModel> getById(int id) async {
    final url = Uri.http(apiURL, '/api/requests/$id');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      final requestModel = RequestModel.fromJson(responseData);
      return requestModel;
    } else {
      throw Exception('Error al obtener el dueño por ID');
    }
  }

  @override
  Future<List<RequestModel>> getByStatus(String status) async {
    final url = Uri.http(apiURL, '/api/requests');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body) as List<dynamic>;
      final List<RequestModel> requestModels = responseData
          .map((data) => RequestModel.fromJson(data))
          .where((request) => request.status == status)
          .toList();
      return requestModels;
    } else {
      throw Exception('Error al obtener las solicitudes por estado');
    }
  }

  @override
  Future<List<RequestModel>> getByUserId(int id) async {
    final url = Uri.http(apiURL, '/api/requests/getByUserId/$id');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      // Aquí asumimos que responseData es una lista de objetos RequestModel
      final List<RequestModel> requestModels = (responseData as List)
          .map((data) => RequestModel.fromJson(data))
          .toList();
      return requestModels;
    } else {
      throw Exception('Error al obtener el dueño por ID');
    }
  }

  @override
  Future<List<RequestModel>> getHistory(int userId)  async{
    final url = Uri.http(apiURL, '/api/requests/$userId');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      // Aquí asumimos que responseData es una lista de objetos RequestModel
      final List<RequestModel> requestModels = (responseData as List)
          .map((data) => RequestModel.fromJson(data))
          .toList();
      return requestModels;
    } else {
      throw Exception('Error al obtener el dueño por ID');
    }
  }

  @override
  Future<List<RequestModel>> getInProgress(int userId) async {
    final url = Uri.http(apiURL, '/api/requests/$userId');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final responseData = convert.jsonDecode(response.body);
      // Aquí asumimos que responseData es una lista de objetos RequestModel
      final List<RequestModel> requestModels = (responseData as List)
          .map((data) => RequestModel.fromJson(data))
          .toList();
      return requestModels;
    } else {
      throw Exception('Error al obtener el dueño por ID');
    }
  }

  @override
  Future<RequestModel> updateRequest(RequestEntity request) async {
    var url = Uri.http(apiURL, '/api/requests/');
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var body = {
      'id': request.id,
      'type': request.type,
      'start_date': request.start_date,
      'end_date': request.end_date,
      'hour': request.hour,
      'duration': request.duration,
      'location': request.location,
      'cost': request.cost,
      'status': request.status,
      'pet_id': request.pet_id,
      'user_id': request.user_id,
      'caretaker_id': request.caretaker_id,
    };
    var response = await http.put(url, body: convert.jsonEncode(body), headers: headers);
    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa, parsea la respuesta y devuelve un objeto PetModel
      var responseData = convert.jsonDecode(response.body);
      var requestModel = RequestModel.fromJson(responseData);
      return requestModel;
    } else {
      // Si la solicitud falló, puedes lanzar una excepción o manejar el error de alguna otra manera
      throw Exception('Error al crear la mascota');
    }
  }
  
}