import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/create_owner_usecase.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/sign_in_with_google_usecase.dart';
import 'package:meta/meta.dart';

part 'owner_event.dart';
part 'owner_state.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  final CreateOwnerUseCase createOwnerUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  OwnerBloc({
    required this.createOwnerUseCase,
    required this.signInWithGoogleUseCase,
  }) : super(OwnerUnAuthenticated()) {
    // on<CreateOwnerEvent>((event, emit) async {
    //   emit(Loading());
    //   emit(OwnerCreatedState(event.owner));
    //   try {
    //     await createOwnerUseCase.execute(event.owner);
    //     emit(OwnerSuccessState('Dueño creado exitosamente'));
    //   } catch (e) {
    //     emit(OwnerUnAuthenticated());
    //     emit(OwnerErrorState('Error al crear el dueño: $e'));
    //   }
    // });

    on<SignInWithGoogleEvent>((event, emit) async {
      emit(Loading());
      try {
        await signInWithGoogleUseCase.execute();
        emit(OwnerSuccessState('Dueño creado exitosamente'));
      } catch (e) {
        emit(OwnerUnAuthenticated());
        emit(OwnerErrorState('Error al crear el dueño: $e'));
      }
    });
  }
}
