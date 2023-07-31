part of 'pet_bloc.dart';

abstract class PetEvent {}

class CreatePetEvent extends PetEvent {
  final List<PetEntity> pets;
  final int userId;

  CreatePetEvent({required this.pets, required this.userId});
}
class DeletePetEvent extends PetEvent {
  final int petId;
  final int userId;

  DeletePetEvent({required this.petId, required this.userId});
}
class UpdatePetEvent extends PetEvent {
  final List<int> petIds;
  List<PetEntity> pets;
  final int userId;

  UpdatePetEvent({required this.petIds, required this.pets, required this.userId});
}
class GetPetsByUserIdEvent extends PetEvent {
  final int id;

  GetPetsByUserIdEvent({required this.id});
}
//sin usar
class GetPetsByIdEvent extends PetEvent {
  final List<int> petsId;

  GetPetsByIdEvent({required this.petsId});
}

