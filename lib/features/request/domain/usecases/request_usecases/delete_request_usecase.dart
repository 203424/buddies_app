import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:buddies_app/features/request/domain/repository/request_repository/request_repository.dart';

class DeleteRequestUseCase {
  final RequestRepository repository;

  DeleteRequestUseCase(this.repository);

  Future<void> execute(int id) async {
    return await repository.deleteRequest(id);
  }
}
