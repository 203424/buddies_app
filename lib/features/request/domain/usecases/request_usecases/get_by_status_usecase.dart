

import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetByStatusUseCase {
  final RequestRepository repository;

  GetByStatusUseCase(this.repository);

  Future<List<RequestEntity>> execute(String status) async {
    return await repository.getByStatus(status);
  }
}