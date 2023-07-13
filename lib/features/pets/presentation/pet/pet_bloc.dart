import 'dart:async';
import 'dart:convert' as convert;

import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import '../../data/models/pet/pet_model.dart';
import '../../domain/entities/pet/pet_entity.dart';
import '../../domain/usecases/pet_usecases/create_pet_usecase.dart';
import '../../domain/usecases/pet_usecases/delete_pet_usecase.dart';
import '../../domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import '../../domain/usecases/pet_usecases/get_pets_usecase.dart';
import '../../domain/usecases/pet_usecases/update_pet_usecase.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final GetPetsUseCase getPetsUseCase;
  final GetPetsByIdUseCase getPetsByIdUseCase;

  PetBloc({
    required this.getPetsUseCase,
    required this.getPetsByIdUseCase,
  }) : super(PetInitialState());

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is GetPetsEvent) {
      yield PetLoadingState();
      try {
        List<PetEntity> response = await getPetsUseCase.execute();
        yield PetLoadedState(response);
      } catch (e) {
        developer.log("Algo salió mal");
        yield PetErrorState(e.toString());
      }
    } else if (event is GetPetsByIdEvent) {
      yield PetLoadingState();
      try {
        List<PetEntity> pets = await getPetsByIdUseCase.execute(event.petId);
        yield PetLoadedState(pets);
      } catch (e) {
        developer.log("Algo salió mal");
        yield PetErrorState(e.toString());
      }
    }
  }
}

class PetBlocModify extends Bloc<PetEvent, PetState> {
  final CreatePetUseCase createPetUseCase;
  final DeletePetUseCase deletePetUseCase;
  final UpdatePetUseCase updatePetUseCase;

  PetBlocModify({
    required this.createPetUseCase,
    required this.deletePetUseCase,
    required this.updatePetUseCase,
  }) : super(PetUpdatingState());

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is CreatePetEvent) {
      yield PetLoadingState();
      try {
        await createPetUseCase.execute(event.pet);
        yield PetUpdatingState();
      } catch (e) {
        developer.log("Algo salió mal al crear una mascota");
        yield PetErrorState(e.toString());
      }
    } else if (event is DeletePetEvent) {
      yield PetLoadingState();
      try {
        await deletePetUseCase.execute(event.petId);
        yield PetUpdatingState();
      } catch (e) {
        developer.log("Algo salió mal al eliminar una mascota");
        yield PetErrorState(e.toString());
      }
    } else if (event is UpdatePetEvent) {
      yield PetLoadingState();
      try {
        await updatePetUseCase.execute(event.petId, event.pet);
        yield PetUpdatingState();
      } catch (e) {
        developer.log("Algo salió mal al actualizar una mascota");
        yield PetErrorState(e.toString());
      }
    }
  }
}


