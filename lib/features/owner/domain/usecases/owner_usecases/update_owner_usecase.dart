

import '../../entities/owner_entity.dart';
import '../../repository/owner_repository.dart';

class UpdateOwnerUseCase {
  final OwnerRepository repository;

  UpdateOwnerUseCase(this.repository);

  Future<List<OwnerEntity>> execute(OwnerEntity owner) async {
    return await repository.updateOwner(owner);
  }
}