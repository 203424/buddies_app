import 'dart:io';

import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';

abstract class Repository{
  Future<void> createRequest(RequestEntity request);
  Future<void> updateRequest(RequestEntity request);
  Future<void> deleteRequest(RequestEntity request);
  Stream<List<RequestEntity>> getAllRequest(RequestEntity request);
  Stream<List<RequestEntity>> getRequestById(RequestEntity request);

}