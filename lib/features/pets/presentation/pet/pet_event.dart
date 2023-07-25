part of 'pet_bloc.dart';

abstract class PetEvent {}

class CreatePetEvent extends PetEvent {
  final List<PetEntity> pets;

  CreatePetEvent({required this.pets});
}

class DeletePetEvent extends PetEvent {
  final int petId;

  DeletePetEvent({required this.petId});
}

class GetPetsByIdEvent extends PetEvent {
  final List<int> petsId;

  GetPetsByIdEvent({required this.petsId});
}

class GetPetsEvent extends PetEvent {}

class UpdatePetEvent extends PetEvent {
  final List<int> petIds;
  List<PetEntity> pets;

  UpdatePetEvent({required this.petIds, required this.pets});
}