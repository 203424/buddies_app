import 'dart:async';


import 'package:bloc/bloc.dart';
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
  final CreatePetUseCase createPetUseCase;
  final DeletePetUseCase deletePetUseCase;
  final UpdatePetUseCase updatePetUseCase;

  PetBloc({
    required this.getPetsUseCase,
    required this.getPetsByIdUseCase,
    required this.createPetUseCase,
    required this.deletePetUseCase,
    required this.updatePetUseCase,
  }) : super(PetInitialState());

  @override
  Stream<PetState> mapEventToState(PetEvent event) async* {
    if (event is GetPetsEvent) {
      yield PetLoadingState();
      try {
        List<PetEntity> pets = await getPetsUseCase.execute();
        if (pets.isEmpty) {
          yield PetEmptyState();
        } else {
          yield PetLoadedState(pets);
        }
      } catch (e) {
        yield PetErrorState( e.toString());
      }
    } else if (event is GetPetsByIdEvent) {
      yield PetLoadingState();
      try {
        List<PetEntity> pets = await getPetsByIdUseCase.execute(event.petId);
        if (pets.isEmpty) {
          yield PetEmptyState();
        } else {
          yield PetLoadedState(pets);
        }
      } catch (e) {
        yield PetErrorState( e.toString());
      }
    } else if (event is CreatePetEvent) {
      yield PetLoadingState();
      try {
        print("object");
        await createPetUseCase.execute(event.pet);
        yield PetSuccessState("Mascota creada exitosamente");
        print("object");

      } catch (e) {
        yield PetErrorState('Error al crear la mascota: $e');
      }
    } else if (event is DeletePetEvent) {
      yield PetLoadingState();
      try {
        await deletePetUseCase.execute(event.petId);
        yield PetSuccessState( "Mascota eliminada exitosamente");
        print('Pet deleted successfully');

      } catch (e) {
        yield PetErrorState( e.toString());
        print('Pet dont deleted successfully' +  e.toString());

      }
    } else if (event is UpdatePetEvent) {
      yield PetLoadingState();
      try {
        await updatePetUseCase.execute(event.petId, event.pet);
        yield PetSuccessState( "Mascota actualizada exitosamente");
      } catch (e) {
        yield PetErrorState( e.toString());
      }
    }
  }
}