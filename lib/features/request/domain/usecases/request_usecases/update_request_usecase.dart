import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class UpdateRequestUseCase {
  final RequestRepository repository;

  UpdateRequestUseCase(this.repository);

  Future<List<RequestEntity>> execute(RequestEntity request) async {
    return await repository.updateRequest(request);
  }
}