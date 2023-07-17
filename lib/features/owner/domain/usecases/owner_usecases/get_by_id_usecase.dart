
import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';
import 'package:buddies_app/features/owner/domain/repository/owner_repository.dart';

class GetOwnerByIdUseCase {
  final OwnerRepository repository;

  GetOwnerByIdUseCase(this.repository);

  Future<OwnerEntity> execute(int ownerid) async{
    return repository.getOwnerById(ownerid);
  }
}