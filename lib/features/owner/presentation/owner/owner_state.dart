part of 'owner_bloc.dart';

@immutable
abstract class OwnerState {}

class OwnerUnAuthenticated extends OwnerState {}

class Loading extends OwnerState {}

class OwnerAuthenticated extends OwnerState {
  final String token;

  OwnerAuthenticated(this.token);
}

class OwnerErrorState extends OwnerState {
  final String errorMessage;

  OwnerErrorState(this.errorMessage);
}

class OwnerCreatedState extends OwnerState {
  final OwnerEntity owner;
  OwnerCreatedState(this.owner);
}

class OwnerSuccessState extends OwnerState {
  final String successMessage;

  OwnerSuccessState(this.successMessage);
}
