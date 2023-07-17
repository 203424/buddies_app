import 'package:buddies_app/features/owner/domain/repository/owner_repository.dart';

class LogOutUseCase {
  final OwnerRepository repository;

  LogOutUseCase(this.repository);

  Future<void> execute() async {
    await repository.logOut();
  }
}