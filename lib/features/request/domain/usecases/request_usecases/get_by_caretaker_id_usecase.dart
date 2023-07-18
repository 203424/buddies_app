


import '../../entities/request/request_entity.dart';
import '../../repository/request_repository/request_repository.dart';

class GetByCaretakerIdUseCase {
  final RequestRepository repository;

  GetByCaretakerIdUseCase(this.repository);

  Future<List<RequestEntity>> execute(int caretakerId) async {
    return await repository.getByCaretakerId(caretakerId);
  }
}