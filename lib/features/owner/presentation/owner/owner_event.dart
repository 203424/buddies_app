part of 'owner_bloc.dart';

@immutable
abstract class OwnerEvent {}

class CreateOwnerEvent extends OwnerEvent {
  final OwnerEntity owner;

  CreateOwnerEvent({required this.owner});
}

class SignInEvent extends OwnerEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});
}

class DeleteOwnerEvent extends OwnerEvent {}

class GetOwnerEvent extends OwnerEvent {}
