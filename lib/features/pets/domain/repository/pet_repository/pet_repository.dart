import 'dart:io';

import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

abstract class PetRepository{
  Future<List<PetEntity>> createPet(List<PetEntity> pets);
  Future<List<PetEntity>> updatePet(List<int> petsIds, List<PetEntity> pets);
  Future<void> deletePet(int petid);
  Future<List<PetEntity>> getPets();
  Future<List<PetEntity>> getPetsById(List<int> petsId);
  Future<List<PetEntity>> getPetsByUserId(int id);

}