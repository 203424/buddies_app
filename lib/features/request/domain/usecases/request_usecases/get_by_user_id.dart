

import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetByUserIdUseCase {
  final RequestRepository repository;

  GetByUserIdUseCase(this.repository);

  Future<List<RequestEntity>> execute(int id) async {
    return await repository.getByUserId(id);
  }
}