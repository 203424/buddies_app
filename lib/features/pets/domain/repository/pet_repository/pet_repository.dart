import 'dart:io';

import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

abstract class PetRepository{
  Future<List<PetEntity>> createPet(PetEntity pet);
  Future<List<PetEntity>> updatePet(int petid, PetEntity pet);
  Future<List<PetEntity>> deletePet(int petid);
  Future<List<PetEntity>> getPets();
  Future<List<PetEntity>> getPetsById(int petid);

}