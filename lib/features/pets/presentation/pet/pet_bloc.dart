import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/create_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/delete_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_by_user_id.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/update_pet_usecase.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  final GetPetsByIdUseCase getPetsByIdUseCase;
  final CreatePetUseCase createPetUseCase;
  final DeletePetUseCase deletePetUseCase;
  final UpdatePetUseCase updatePetUseCase;
  final GetPetsByUserIdUseCase getPetsByUserIdUseCase;

  PetBloc({
    required this.getPetsByIdUseCase,
    required this.createPetUseCase,
    required this.deletePetUseCase,
    required this.updatePetUseCase,
    required this.getPetsByUserIdUseCase,
  }) : super(PetInitialState()) {
    on<GetPetsByUserIdEvent>((event, emit) async {
      emit(PetLoadingState());
      try {
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.id);
        emit(PetLoadedState(pets));
      } catch (e) {
        emit(PetErrorState(e.toString()));
      }
    });

    on<GetPetsByIdEvent>((event, emit) async {
      emit(PetLoadingState());
      try {
        List<PetEntity> pets = await getPetsByIdUseCase.execute(event.petsId);
        emit(PetLoadedState(pets));
      } catch (e) {
        emit(PetErrorState(e.toString()));
      }
    });

    on<CreatePetEvent>((event, emit) async {
      // emit(PetCreatedState(event.pets));
      emit(PetLoadingState());
      try {
        await createPetUseCase.execute(event.pets);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        emit(PetLoadedState(pets));
      } catch (e) {
        emit(PetErrorState('Error al registrar la mascota: $e'));
      }
    });

    on<DeletePetEvent>((event, emit) async {
      // emit(PetDeletedState(event.petId));
      emit(PetLoadingState());
      try {
        await deletePetUseCase.execute(event.petId);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        emit(PetLoadedState(pets));
      } catch (e) {
        emit(PetErrorState(e.toString()));
        print('Pet dont deleted successfully' + e.toString());
      }
    });

    on<UpdatePetEvent>((event, emit) async {
      // emit(PetUpdatedState(event.pets, event.petIds));
      emit(PetLoadingState());
      try {
        await updatePetUseCase.execute(event.petIds, event.pets);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        emit(PetLoadedState(pets));
      } catch (e) {
        emit(PetErrorState(e.toString()));
      }
    });
  }
}
