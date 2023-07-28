import '../../repository/owner_repository.dart';

class SignInWithGoogleUseCase {
  final OwnerRepository repository;

  SignInWithGoogleUseCase(this.repository);

  Future<void> execute() async {
    await repository.signInWithGoogle();
  }
}
