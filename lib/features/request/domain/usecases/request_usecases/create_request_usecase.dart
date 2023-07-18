import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:buddies_app/features/request/domain/repository/request_repository/request_repository.dart';

class CreateRequestUseCase {
  final RequestRepository repository;

  CreateRequestUseCase(this.repository);

  Future<RequestEntity> execute(RequestEntity  request) async {
    return await repository.createRequest(request);
  }
}