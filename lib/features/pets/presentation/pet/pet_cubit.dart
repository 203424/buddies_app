import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/delete_pet_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_by_id_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_usecase.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/update_pet_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/pet/pet_entity.dart';

part 'pet_state.dart';

class PetCubit extends Cubit<PetState> {
  final UpdatePetUseCase updatePetUseCase;
  final GetPetsUseCase getPetsUseCase;
  final GetPetsByIdUseCase getPetsByIdUseCase;
  final DeletePetUseCase deletePetUseCase;


  PetCubit({required this.updatePetUseCase, required this.getPetsUseCase, required this.getPetsByIdUseCase, required this.deletePetUseCase   }) : super(PetInitial());

  Future<void> getPets() async {
    emit(PetLoading());
    try {
      final List<PetEntity> pets = await getPetsUseCase.execute();
      emit(PetLoaded(pets: pets));
    } on SocketException catch (_) {
      emit(PetFailure());
    } catch (_) {
      emit(PetFailure());
    }
  }

  Future<void> getPetsById() async {
    emit(PetLoading());
    try {
      final List<PetEntity> pets = await getPetsByIdUseCase.execute();
      emit(PetLoaded(pets: pets));
    } on SocketException catch (_) {
      emit(PetFailure());
    } catch (_) {
      emit(PetFailure());
    }
  }

  Future<void> updatePet({required PetEntity pet}) async {
    try {
      await updatePetUseCase.call(pet);
    } on SocketException catch(_) {
      emit(PetFailure());
    } catch (_) {
      emit(PetFailure());
    }
  }

  Future<void> deletePet({required PetEntity pet}) async {
    try {
      await deletePetUseCase.call(pet);
    } on SocketException catch(_) {
      emit(PetFailure());
    } catch (_) {
      emit(PetFailure());
    }
  }
}
