import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:buddies_app/features/request/domain/repository/request_repository/repository.dart';

class GetRequestByIdUseCase {
  final Repository repository;

  GetRequestByIdUseCase({required this.repository});

  Stream<List<RequestEntity>> call(RequestEntity request) {
    return repository.getRequestById(request);
  }
}