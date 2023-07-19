import 'dart:io';

import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';

abstract class RequestRepository{
  Future<RequestEntity> createRequest(RequestEntity request);
  Future <RequestEntity> updateRequest(RequestEntity request);
  Future<void> deleteRequest(int id);
  Future<RequestEntity> getById(int id);
  Future<List<RequestEntity>> getByUserId(int id);
  Future<List<RequestEntity>> getAllRequests();
  Future<List<RequestEntity>> getByStatus(String status);
  Future<List<RequestEntity>> getInProgress(int userId);
  Future<List<RequestEntity>> getHistory(int userId);
  Future<List<RequestEntity>> getByCaretakerId(int caretakerId);
}