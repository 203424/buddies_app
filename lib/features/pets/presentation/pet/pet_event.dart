part of 'pet_bloc.dart';

abstract class PetEvent {}

class CreatePetEvent extends PetEvent {
  final PetEntity pet;

  CreatePetEvent({required this.pet});
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
  final int petId;
  final PetEntity pet;

  UpdatePetEvent({required this.petId, required this.pet});
}