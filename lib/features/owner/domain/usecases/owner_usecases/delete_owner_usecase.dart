

import 'package:buddies_app/features/owner/domain/repository/owner_repository.dart';

class DeleteOwnerUseCase {
  final OwnerRepository repository;

  DeleteOwnerUseCase(this.repository);

  Future<void> execute(int ownerid) async {
    return await repository.deleteOwner(ownerid);
  }
}