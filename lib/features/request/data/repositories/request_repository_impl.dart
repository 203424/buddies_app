

import 'package:buddies_app/features/request/data/data_sources/request_remote.dart';
import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:buddies_app/features/request/domain/repository/request_repository/request_repository.dart';

class RequestRepositoryImpl implements RequestRepository{

  final RequestRemoteDataSource requestRemoteDataSource;

  RequestRepositoryImpl({required this.requestRemoteDataSource});

  @override
  Future<RequestEntity> createRequest(RequestEntity request) async {
    return await requestRemoteDataSource.createRequest(request);
  }

  @override
  Future<void> deleteRequest(int id) async {
    return await requestRemoteDataSource.deleteRequest(id);

  }

  @override
  Future<List<RequestEntity>> getAllRequests() async {
    return await requestRemoteDataSource.getAllRequests();

  }

  @override
  Future<List<RequestEntity>> getByCaretakerId(int caretakerId) async {
    return await requestRemoteDataSource.getByCaretakerId(caretakerId);

  }

  @override
  Future<RequestEntity> getById(int id) async {
    return await requestRemoteDataSource.getById(id);

  }

  @override
  Future<List<RequestEntity>> getByStatus(String status) async {
    return await requestRemoteDataSource.getByStatus(status);

  }

  @override
  Future<List<RequestEntity>> getByUserId(int id) async {
    return await requestRemoteDataSource.getByUserId(id);

  }

  @override
  Future<List<RequestEntity>> getHistory(int userId) async {
    return await requestRemoteDataSource.getHistory(userId);

  }

  @override
  Future<List<RequestEntity>> getInProgress(int userId) async {
    return await requestRemoteDataSource.getInProgress(userId);

  }

  @override
  Future<List<RequestEntity>> updateRequest(RequestEntity request) async {
    return await requestRemoteDataSource.updateRequest(request);

  }
  
}