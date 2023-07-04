part of 'pet_cubit.dart';

abstract class PetState extends Equatable {
  const PetState();
}

class PetInitial extends PetState {
  @override
  List<Object> get props => [];
}

class PetLoading extends PetState {
  @override
  List<Object> get props => [];
}


class PetLoaded extends PetState {
  final List<PetEntity> pets;

  PetLoaded({required this.pets});
  @override
  List<Object> get props => [pets];
}


class PetFailure extends PetState {
  @override
  List<Object> get props => [];
}