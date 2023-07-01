import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/repository.dart';


class GetPetsUseCase {
  final Repository repository;

  GetPetsUseCase({required this.repository});

  Stream<List<PetEntity>> call(PetEntity pet) {
    return repository.getPets(pet);
  }
}
