import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';

class CreatePetUseCase {
  final PetRepository repository;

  CreatePetUseCase(this.repository);

  Future<List<PetEntity>> execute(PetEntity  pet) async {
    return await repository.createPet(pet);
  }
}