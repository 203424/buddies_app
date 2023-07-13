part of 'pet_bloc.dart';

abstract class PetState {}

class PetInitialState extends PetState {}

class PetLoadingState extends PetState {}

class PetUpdatingState extends PetState {}

class PetUpdatedState extends PetState {}

class PetLoadedState extends PetState {
  final List<PetEntity> pets; // Campo que contiene la lista de mascotas

  PetLoadedState(this.pets);

// Resto de la implementación de la clase
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