import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/repository.dart';

class GetPetsByIdUseCase {
  final Repository repository;

  GetPetsByIdUseCase({required this.repository});

  Stream<List<PetEntity>> call(PetEntity pet) {
    return repository.getPetsById(pet);
  }
}