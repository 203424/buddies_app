

import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';

import '../../repository/owner_repository.dart';

class CreateOwnerUseCase {
  final OwnerRepository repository;

  CreateOwnerUseCase(this.repository);

  Future<OwnerEntity> execute(OwnerEntity  owner) async {
    return await repository.createOwner(owner);
  }
}