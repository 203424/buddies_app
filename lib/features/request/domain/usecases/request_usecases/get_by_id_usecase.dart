


import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetByIdUseCase {
  final RequestRepository repository;

  GetByIdUseCase(this.repository);

  Future<RequestEntity> execute(int id) async {
    return await repository.getById(id);
  }
}