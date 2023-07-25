import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/create_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/delete_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/update_pet_usecase.dart';

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
  }) : super(PetInitialState()) {
    on<GetPetsEvent>((event, emit) async {
      emit(PetLoadingState());
      try {
        List<PetEntity> pets = await getPetsUseCase.execute();
        if (pets.isEmpty) {
          emit(PetEmptyState());
        } else {
          emit(PetLoadedState(pets));
        }
      } catch (e) {
        emit(PetErrorState(e.toString()));
      }
    });

    on<GetPetsByIdEvent>((event, emit) async {
      emit(PetLoadingState());
      try {
        List<PetEntity> pets = await getPetsByIdUseCase.execute(event.petsId);
        if (pets.isEmpty) {
          emit(PetEmptyState());
        } else {
          emit(PetLoadedState(pets));
        }
      } catch (e) {
        emit(PetErrorState(e.toString()));
      }
    });

    on<CreatePetEvent>((event, emit) async {
      emit(PetCreatedState(event.pets));
      try {
        await createPetUseCase.execute(event.pets);
        emit(PetSuccessState("Mascota creada exitosamente"));
      } catch (e) {
        emit(PetErrorState('Error al crear la mascota: $e'));
      }
    });

    on<DeletePetEvent>((event, emit) async {
      emit(PetDeletedState(event.petId));
      try {
        await deletePetUseCase.execute(event.petId);
        emit(PetSuccessState("Mascota eliminada exitosamente"));
        print('Pet deleted successfully');
      } catch (e) {
        emit(PetErrorState(e.toString()));
        print('Pet dont deleted successfully' + e.toString());
      }
    });

    on<UpdatePetEvent>((event, emit) async {
      emit(PetUpdatedState(event.pets, event.petIds));
      try {
        await updatePetUseCase.execute(event.petIds, event.pets);
        emit(PetSuccessState("Mascota actualizada exitosamente"));
      } catch (e) {
        emit(PetErrorState(e.toString()));
      }
    });
  }
}
