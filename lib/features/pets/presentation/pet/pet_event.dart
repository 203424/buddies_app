part of 'pet_bloc.dart';

@immutable
abstract class PetEvent {}

class CreatePetEvent extends PetEvent {
  final PetEntity pet;

  CreatePetEvent(this.pet);
}

class DeletePetEvent extends PetEvent {
  final int petId;

  DeletePetEvent(this.petId);
}

class GetPetsByIdEvent extends PetEvent {
  final int petId;

  GetPetsByIdEvent(this.petId);
}

class GetPetsEvent extends PetEvent {}

class UpdatePetEvent extends PetEvent {
  final int petId;
  final PetEntity pet;

  UpdatePetEvent(this.petId, this.pet);
}
