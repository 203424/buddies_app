part of 'owner_bloc.dart';

@immutable
abstract class OwnerEvent {}

class CreateOwnerEvent extends OwnerEvent {
  final OwnerEntity owner;

  CreateOwnerEvent({required this.owner});
}

class SignInWithGoogleEvent extends OwnerEvent {}
