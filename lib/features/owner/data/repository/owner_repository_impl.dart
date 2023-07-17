
import 'package:buddies_app/features/owner/data/data_sources/owner_remote.dart';
import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';

import '../../domain/repository/owner_repository.dart';

class OwnerRepositoryImpl implements OwnerRepository {
  final OwnerRemoteDataSource ownerRemoteDataSource;

  OwnerRepositoryImpl({required this.ownerRemoteDataSource});

  @override
  Future<OwnerEntity> createOwner(OwnerEntity owner) async {
    return await ownerRemoteDataSource.createOwner(owner);
  }

  @override
  Future<void> deleteOwner(int ownerid) async {
    return await ownerRemoteDataSource.deleteOwner(ownerid);
  }

  @override
  Future<OwnerEntity> getOwnerById(int ownerid) async {
    return await ownerRemoteDataSource.getOwnerById(ownerid);
  }

  @override
  Future<void> logOut() async {
    return await ownerRemoteDataSource.logOut();
  }

  @override
  Future<OwnerEntity> signIn(String email, String password) async {
    return await ownerRemoteDataSource.signIn(email, password);
  }

  @override
  Future<List<OwnerEntity>> updateOwner(OwnerEntity owner) async {
    return await ownerRemoteDataSource.updateOwner(owner);

  }
}