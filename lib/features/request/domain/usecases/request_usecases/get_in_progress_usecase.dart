
import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetInProgressUseCase {
  final RequestRepository repository;

  GetInProgressUseCase(this.repository);

  Future<List<RequestEntity>> execute(int userId) async {
    return await repository.getInProgress(userId);
  }
}