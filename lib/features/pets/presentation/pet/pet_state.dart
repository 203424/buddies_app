part of 'pet_bloc.dart';


abstract class PetState {}

class PetInitialState extends PetState {}

class PetLoadingState extends PetState {}

class PetLoadedState extends PetState {
  final List<PetEntity> pets;

  PetLoadedState(this.pets);
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
class PetDeletedState extends PetState {
  int id;
  PetDeletedState(this.id);
}
class PetCreatedState extends PetState {
  final List<PetEntity> pets;
  PetCreatedState(this.pets);

}
class PetUpdatedState extends PetState {
  final List<PetEntity> pets;
  final List<int>petIds;
  PetUpdatedState(this.pets, this.petIds);


}

