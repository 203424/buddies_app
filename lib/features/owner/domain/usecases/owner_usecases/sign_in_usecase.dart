import '../../entities/owner_entity.dart';
import '../../repository/owner_repository.dart';

class SignInUseCase {
  final OwnerRepository repository;

  SignInUseCase(this.repository);

  Future<String> execute(String email, String password) async {

    final String token = await repository.signIn(email, password);
    return token;
  }
}