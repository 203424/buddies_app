import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';

class GetPetsByIdUseCase {
  final PetRepository repository;

  GetPetsByIdUseCase(this.repository);

  Future<List<PetEntity>> execute(List<int> petsId) async{
    return repository.getPetsById(petsId);
  }
}