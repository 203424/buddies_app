
import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetHistoryUseCase {
  final RequestRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<RequestEntity>> execute(int userId) async {
    return await repository.getHistory(userId);
  }
}