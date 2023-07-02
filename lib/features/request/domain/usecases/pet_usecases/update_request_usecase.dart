import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:buddies_app/features/request/domain/repository/request_repository/repository.dart';

class UpdateRequestUseCase {
  final Repository repository;

  UpdateRequestUseCase({required this.repository});

  Future<void> call(RequestEntity request) {
    return repository.updateRequest(request);
  }
}