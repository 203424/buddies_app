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
  Future<void> deleteOwner() async {
    return await ownerRemoteDataSource.deleteOwner();
  }

  @override
  Future<OwnerEntity> getOwnerById() async {
    return await ownerRemoteDataSource.getOwnerById();
  }

  @override
  Future<void> logOut() async {
    return await ownerRemoteDataSource.logOut();
  }

  @override
  Future<String> signIn(String email, String password) async {
    return await ownerRemoteDataSource.signIn(email, password);
  }

  @override
  Future<List<OwnerEntity>> updateOwner(OwnerEntity owner) async {
    return await ownerRemoteDataSource.updateOwner(owner);
  }
}
