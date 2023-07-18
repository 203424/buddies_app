

import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetAllRequestUseCase {
  final RequestRepository repository;

  GetAllRequestUseCase(this.repository);

  Future<List<RequestEntity>> execute() async {
    return await repository.getAllRequests();
  }
}