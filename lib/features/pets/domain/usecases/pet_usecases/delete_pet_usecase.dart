import 'package:buddies_app/features/pets/domain/repository/pet_repository/pet_repository.dart';

class DeletePetUseCase {
  final PetRepository repository;

  DeletePetUseCase(this.repository);

  Future<void> execute(int petid) async {
    return await repository.deletePet(petid);
  }
}