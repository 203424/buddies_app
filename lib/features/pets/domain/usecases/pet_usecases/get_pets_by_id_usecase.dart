import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';

class GetPetsByIdUseCase {
  final PetRepository repository;

  GetPetsByIdUseCase({required this.repository});

  Future<List<PetEntity>> execute() async{
    return repository.getPetsById();
  }
}