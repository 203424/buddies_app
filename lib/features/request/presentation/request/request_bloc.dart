
import 'package:bloc/bloc.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/domain/usecases/pet_usecases/get_pets_by_user_id.dart';
import '../../domain/entities/request/request_entity.dart';
import '../../domain/usecases/request_usecases/create_request_usecase.dart';
import '../../domain/usecases/request_usecases/delete_request_usecase.dart';
import '../../domain/usecases/request_usecases/get_all_requests_usecase.dart';
import '../../domain/usecases/request_usecases/get_by_caretaker_id_usecase.dart';
import '../../domain/usecases/request_usecases/get_by_id_usecase.dart';
import '../../domain/usecases/request_usecases/get_by_status_usecase.dart';
import '../../domain/usecases/request_usecases/get_by_user_id.dart';
import '../../domain/usecases/request_usecases/get_history_usecase.dart';
import '../../domain/usecases/request_usecases/get_in_progress_usecase.dart';
import '../../domain/usecases/request_usecases/update_request_usecase.dart';

part 'request_event.dart';
part 'request_state.dart';

class RequestBloc extends Bloc<RequestEvent, RequestState> {

  final CreateRequestUseCase createRequestUseCase;
  final UpdateRequestUseCase updateRequestUseCase;
  final DeleteRequestUseCase deleteRequestUseCase;
  final GetByIdUseCase getByIdUseCase;
  final GetByUserIdUseCase getByUserIdUseCase;
  final GetAllRequestUseCase getAllRequestUseCase;
  final GetByStatusUseCase getByStatusUseCase;
  final GetInProgressUseCase getInProgressUseCase;
  final GetHistoryUseCase getHistoryUseCase;
  final GetByCaretakerIdUseCase getByCaretakerIdUseCase;
  final GetPetsByUserIdUseCase getPetsByUserIdUseCase;

  RequestBloc({
    required this.createRequestUseCase,
    required this.updateRequestUseCase,
    required this.deleteRequestUseCase,
    required this.getByIdUseCase,
    required this.getByUserIdUseCase,
    required this.getAllRequestUseCase,
    required this.getByStatusUseCase,
    required this.getInProgressUseCase,
    required this.getHistoryUseCase,
    required this.getByCaretakerIdUseCase,
    required this.getPetsByUserIdUseCase

  }) : super(RequestInitialState())
  {

    on<GetAllRequestsEvent>((event, emit) async {
      emit(RequestLoadingState());
      try {
        List<RequestEntity> request = await getAllRequestUseCase.execute();
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        if (request.isEmpty) {
          emit(RequestEmptyState());
        } else {
          emit(RequestLoadedState(request, pets));
        }
      } catch (e) {
        emit(RequestErrorState(e.toString()));
        print('object');
      }
    });

    on<GetByUserIdEvent>((event, emit) async {
      emit(RequestLoadingState());
      try {
        List<RequestEntity> request = await getByUserIdUseCase.execute(event.userId);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        if (request.isEmpty) {
          emit(RequestEmptyState());
        } else {
          emit(RequestLoadedState(request, pets));
        }
      } catch (e) {
        emit(RequestErrorState(e.toString()));
      }
    });

    on<GetInProgressEvent>((event, emit) async {
      emit(RequestGetState(event.userId));
      try {
        List<RequestEntity> request = await getInProgressUseCase.execute(event.userId);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        if (request.isEmpty) {
          emit(RequestEmptyState());
        } else {
          emit(RequestLoadedState(request,pets));
        }
      } catch (e) {
        emit(RequestErrorState(e.toString()));
      }
    });

    on<GetHistoryEvent>((event, emit) async {
      emit(RequestGetState(event.userId));
      try {
        List<RequestEntity> request = await getHistoryUseCase.execute(event.userId);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        if (request.isEmpty) {
          emit(RequestEmptyState());
        } else {
          emit(RequestLoadedState(request,pets));
        }
      } catch (e) {
        emit(RequestErrorState(e.toString()));
      }
    });

    on<GetByCaretakerIdEvent>((event, emit) async {
      emit(RequestGetState(event.caretakerId));
      try {
        List<RequestEntity> request = await getByCaretakerIdUseCase.execute(event.caretakerId);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        if (request.isEmpty) {
          emit(RequestEmptyState());
        } else {
          emit(RequestLoadedState(request,pets));
        }
      } catch (e) {
        emit(RequestErrorState(e.toString()));
      }
    });

    on<GetByStatusEvent>((event, emit) async {
      emit(RequestStatusState(event.status));
      try {
        List<RequestEntity> request = await getByStatusUseCase.execute(event.status);
        List<PetEntity> pets = await getPetsByUserIdUseCase.execute(event.userId);
        if (request.isEmpty) {
          emit(RequestEmptyState());
        } else {
          emit(RequestLoadedState(request,pets));
        }
      } catch (e) {
        emit(RequestErrorState(e.toString()));
      }
    });





    on<GetByIdEvent>((event, emit) async {
      emit(RequestGetState(event.requestId));
      try {
        await getByIdUseCase.execute(event.requestId);
        emit(RequestSuccessState("Request creada exitosamente"));
      } catch (e) {
        emit(RequestErrorState('Error al crear la Request: $e'));
      }
    });



    on<CreateRequestEvent>((event, emit) async {
      emit(RequestCreatedState(event.request));
      try {
        await createRequestUseCase.execute(event.request);
        emit(RequestSuccessState("Request creada exitosamente"));
      } catch (e) {
        emit(RequestErrorState('Error al crear la Request: $e'));
      }
    });


    on<DeleteRequestEvent>((event, emit) async {
      emit(RequestDeletedState(event.requestId));
      try {
        await deleteRequestUseCase.execute(event.requestId);
        emit(RequestSuccessState("Request eliminada exitosamente"));
        print('Request deleted successfully');
      } catch (e) {
        emit(RequestErrorState(e.toString()));
        print('Request didnt delete successfully' + e.toString());
      }
    });

    on<UpdateRequestEvent>((event, emit) async {
      emit(RequestUpdatedState(event.request));
      try {
        await updateRequestUseCase.execute(event.request);
        emit(RequestSuccessState("Request actualizada exitosamente"));
        print('Request actualizada successfully');
      } catch (e) {
        emit(RequestErrorState(e.toString()));
        print('Request didnt update successfully' + e.toString());
      }
    });



  }
}