import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/repository.dart';

class CreatePetUseCase {
  final Repository repository;

  CreatePetUseCase({required this.repository});

  Future<void> call(PetEntity pet) {
    return repository.createPet(pet);
  }
}