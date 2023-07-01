import 'dart:io';

import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

abstract class Repository{
  Future<void> createPet(PetEntity pet);
  Future<void> updatePet(PetEntity pet);
  Future<void> deletePet(PetEntity pet);
  Stream<List<PetEntity>> getPets(PetEntity pet);
  Stream<List<PetEntity>> getPetsById(PetEntity pet);

}