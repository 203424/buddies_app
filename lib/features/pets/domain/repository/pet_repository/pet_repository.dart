import 'dart:io';

import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

abstract class PetRepository{
  Future<void> createPet(List<PetEntity> pet);
  Future<void> updatePet(PetEntity pet);
  Future<void> deletePet(PetEntity pet);
  Future<List<PetEntity>> getPets();
  Future<List<PetEntity>> getPetsById();

}