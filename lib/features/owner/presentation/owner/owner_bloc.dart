import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/create_owner_usecase.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/delete_owner_usecase.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/get_by_id_usecase.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/sign_in_usecase.dart';
import 'package:buddies_app/features/owner/domain/usecases/owner_usecases/update_owner_usecase.dart';
import 'package:meta/meta.dart';

part 'owner_event.dart';
part 'owner_state.dart';

class OwnerBloc extends Bloc<OwnerEvent, OwnerState> {
  final GetOwnerByIdUseCase getOwnerByIdUseCase;
  final CreateOwnerUseCase createOwnerUseCase;
  final SignInUseCase signInUseCase;
  final DeleteOwnerUseCase deleteOwnerUseCase;
  final UpdateOwnerUseCase updateOwnerUseCase;

  OwnerBloc({
    required this.getOwnerByIdUseCase,
    required this.createOwnerUseCase,
    required this.signInUseCase,
    required this.deleteOwnerUseCase,
    required this.updateOwnerUseCase,
  }) : super(OwnerUnAuthenticated()) {
    on<GetOwnerEvent>((event, emit) async {
      emit(Loading());
      try {
        final owner = await getOwnerByIdUseCase.execute();
        emit(OwnerCreatedState(owner));
      } catch (e) {
        emit(OwnerErrorState('Error: $e'));
      }
    });

    on<CreateOwnerEvent>((event, emit) async {
      emit(Loading());
      try {
        final owner = await createOwnerUseCase.execute(event.owner);
        emit(OwnerCreatedState(owner));
      } catch (e) {
        emit(OwnerErrorState('Error: $e'));
      }
    });

    on<SignInEvent>((event, emit) async {
      emit(Loading());
      try {
        var token = await signInUseCase.execute(event.email, event.password);
        emit(OwnerAuthenticated(token));
      } catch (e) {
        emit(OwnerErrorState('Error: $e'));
        emit(OwnerUnAuthenticated());
      }
    });

    on<DeleteOwnerEvent>((event, emit) async {
      emit(Loading());
      try {
        await deleteOwnerUseCase.execute();
        emit(OwnerDeleted());
      } catch (e) {
        emit(OwnerErrorState('Error: $e'));
      }
    });
  }
}
