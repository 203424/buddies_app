import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/create_owner_usecase.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/sign_in_usecase.dart';
import 'package:meta/meta.dart';

part 'owner_event.dart';
part 'owner_state.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  final CreateOwnerUseCase createOwnerUseCase;
  final SignInUseCase signInUseCase;

  OwnerBloc({required this.createOwnerUseCase, required this.signInUseCase})
      : super(OwnerUnAuthenticated()) {
    on<CreateOwnerEvent>((event, emit) async {
      emit(Loading());
      try {
        await createOwnerUseCase.execute(event.owner);
        emit(OwnerSuccessState('Se ha registrado exitosamente'));
      } catch (e) {
        emit(OwnerErrorState('Error: $e'));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(Loading());
      try {
        var owner = await signInUseCase.execute(event.email, event.password);
        emit(OwnerAuthenticated(owner.id.toString()));
      } catch (e) {
        emit(OwnerErrorState('Error: $e'));
      }
    });
  }
}
