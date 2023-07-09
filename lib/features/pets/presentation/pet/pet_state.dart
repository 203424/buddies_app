part of 'pet_bloc.dart';

@immutable
abstract class PetState {}

class PetInitialState extends PetState {}

class PetLoadingState extends PetState {}

class PetLoadedState extends PetState {
  final List<PetModel> petList;

  PetLoadedState(this.petList);
}

class PetEmptyState extends PetState {}

class PetErrorState extends PetState {
  final String errorMessage;

  PetErrorState(this.errorMessage);
}

class PetSuccessState extends PetState {
  final String successMessage;

  PetSuccessState(this.successMessage);
}