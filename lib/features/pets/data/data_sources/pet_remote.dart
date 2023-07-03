import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:buddies_app/features/pets/data/models/pet/pet_model.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

String apiURL = '3.215.246.49';

abstract class PetRemoteDataSource {
  Future<List<PetModel>> getPets();
  Future<List<PetModel>> getPetsById();

  Future<void> createPet(List<PetEntity> pet);
  Future<void> updatePet(PetEntity pet);
  Future<void> deletePet(PetEntity pet);
}

class PetRemoteDataSourceImp implements PetRemoteDataSource {


  @override
  Future<List<PetModel>> getPets() async {
    var url = Uri.https(apiURL, '/api/tareas/');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var dataPets = convert
          .jsonDecode(response.body)
          .map<PetModel>((data) => PetModel.fromJson(data))
          .toList();
     // final prefs = await SharedPreferences.getInstance();
     // prefs.setString('tareas', response.body);
      return dataPets;
    } else {
      throw Exception('Error');
    }
  }

  @override
  Future<void> createPet(List<PetEntity> pets) async  {
    var url = Uri.https(apiURL, '/api/tareas/');
    var headers = {'Content-Type': 'application/json'};

    List<Map<String, Object>> body = [];

    for (var PetEntity in pets) {
      var object = {
        'description': PetEntity.description!,
        'size': PetEntity.size!,
        'gender': PetEntity.gender!,
        'breed': PetEntity.breed!,
        'type': PetEntity.type!,
        'birthday': PetEntity.birthday!,
        'name': PetEntity.name!,
      };

      body.add(object);
    }

    await http.post(url, body: convert.jsonEncode(body), headers: headers);

  }

  @override
  Future<void> deletePet(PetEntity pet) async {
      var url = Uri.https(apiURL, '/api/tareas/${pet.id}');
      await http.delete(url);
  }

  @override
  Future<List<PetModel>> getPetsById() {
    // TODO: implement getPetsById
    throw UnimplementedError();
  }


  @override
  Future<void> updatePet(PetEntity pet) async {
    var url = Uri.https(apiURL, '/api/tareas/');
    var headers = {'Content-Type': 'application/json'};


    var body = {
      'description': pet.description!,
      'size': pet.size!,
      'gender': pet.gender!,
      'breed': pet.breed!,
      'type': pet.type!,
      'birthday': pet.birthday!,
      'name': pet.name!,
    };
    print("update");
    print(body);

    await http.put(url, body: convert.jsonEncode(body), headers: headers);
  }


}
