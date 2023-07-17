import '../../entities/owner_entity.dart';
import '../../repository/owner_repository.dart';

class SignInUseCase {
  final OwnerRepository repository;

  SignInUseCase(this.repository);

  Future<OwnerEntity> execute(String email, String password) async {

    final OwnerEntity signedInOwner = await repository.signIn(email, password);
    return signedInOwner;
  }
}