import 'dart:io';

import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

abstract class PetRepository{
  Future<PetEntity> createPet(PetEntity pet);
  Future<PetEntity> updatePet(int petid, PetEntity pet);
  Future<void> deletePet(int petid);
  Future<List<PetEntity>> getPets();
  Future<List<PetEntity>> getPetsById(List<int> petsId);

}