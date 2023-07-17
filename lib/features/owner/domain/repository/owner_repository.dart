import 'dart:io';

import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';

abstract class OwnerRepository{
  Future<OwnerEntity> createOwner(OwnerEntity owner);
  Future<List<OwnerEntity>> updateOwner(OwnerEntity owner);
  Future<void> deleteOwner(int ownerid);
  Future<OwnerEntity> getOwnerById(int ownerid);
  Future<OwnerEntity> signIn(String email, String password );
  Future<void> logOut();
}