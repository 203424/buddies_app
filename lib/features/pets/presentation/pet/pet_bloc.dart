import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
  final CreatePetUseCase createPetUseCase;
  final DeletePetUseCase deletePetUseCase;
  final GetPetsByIdUseCase getPetsByIdUseCase;
  final GetPetsUseCase getPetsUseCase;
  final UpdatePetUseCase updatePetUseCase;

  PetBloc({
    required this.createPetUseCase,
    required this.deletePetUseCase,
    required this.getPetsByIdUseCase,
    required this.getPetsUseCase,
    required this.updatePetUseCase,
  }) : super(PetInitialState());

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is CreatePetEvent) {
      yield PetLoadingState();

      try {
        await createPetUseCase.repository.createPet(event.pet);
        yield PetSuccessState('Mascota creada exitosamente');
      } catch (e) {
        yield PetErrorState('Error al crear la mascota');
      }
    } else if (event is DeletePetEvent) {
      yield PetLoadingState();

      try {
        await deletePetUseCase.repository.deletePet(event.petId);
        yield PetSuccessState('Mascota eliminada exitosamente');
      } catch (e) {
        yield PetErrorState('Error al eliminar la mascota');
      }
    } else if (event is GetPetsByIdEvent) {
      yield PetLoadingState();

      try {
        final petList = await getPetsUseCase.repository.getPets();
        final petModelList = petList.map((petEntity) => PetModel.fromEntity(petEntity)).toList();
        yield PetLoadedState(petModelList);
      } catch (e) {
        yield PetErrorState('Error al obtener las mascotas');
      }
    } else if (event is GetPetsEvent) {
      yield PetLoadingState();

      try {
        final petList = await getPetsUseCase.repository.getPets();
        final petModelList = petList.map((petEntity) => PetModel.fromEntity(petEntity)).toList();
        yield PetLoadedState(petModelList);
      } catch (e) {
        yield PetErrorState('Error al obtener las mascotas');
      }
    } else if (event is UpdatePetEvent) {
      yield PetLoadingState();

      try {
        await updatePetUseCase.repository.updatePet(event.petId, event.pet);
        yield PetSuccessState('Mascota actualizada exitosamente');
      } catch (e) {
        yield PetErrorState('Error al actualizar la mascota');
      }
    }
  }
}
