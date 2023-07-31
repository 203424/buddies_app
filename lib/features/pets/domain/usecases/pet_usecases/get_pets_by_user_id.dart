import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';


class GetPetsByUserIdUseCase {
  final PetRepository repository;

  GetPetsByUserIdUseCase(this.repository);

  Future<List<PetEntity>> execute(int id) async {
    return repository.getPetsByUserId(id );
  }
}
