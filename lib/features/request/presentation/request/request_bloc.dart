import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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

  }) : super(RequestInitial());


  @override
  Stream<RequestState> mapEventToState(RequestEvent event) async* {
    if (event is CreateRequest) {
      try {
        await createRequestUseCase.execute(event.request);
        final requests = await getAllRequestUseCase.execute();
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al crear la solicitud');
      }
    } else if (event is UpdateRequest) {
      try {
        await updateRequestUseCase.execute(event.request);
        final requests = await getAllRequestUseCase.execute();
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al actualizar la solicitud');
      }
    } else if (event is DeleteRequest) {
      try {
        await deleteRequestUseCase.execute(event.requestId);
        final requests = await getAllRequestUseCase.execute();
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al eliminar la solicitud');
      }
    } else if (event is GetById) {
      try {
        final request = await getByIdUseCase.execute(event.requestId);
        yield RequestLoaded([request]);
      } catch (e) {
        yield RequestError('Error al obtener la solicitud por ID');
      }
    } else if (event is GetByUserId) {
      try {
        final requests = await getByUserIdUseCase.execute(event.userId);
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al obtener las solicitudes por ID de usuario');
      }
    } else if (event is GetAllRequests) {
      try {
        final requests = await getAllRequestUseCase.execute();
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al obtener todas las solicitudes');
      }
    } else if (event is GetByStatus) {
      try {
        final requests = await getByStatusUseCase.execute(event.status);
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al obtener las solicitudes por estado');
      }
    } else if (event is GetInProgress) {
      try {
        final requests = await getInProgressUseCase.execute(event.userId);
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al obtener las solicitudes en progreso');
      }
    } else if (event is GetHistory) {
      try {
        final requests = await getHistoryUseCase.execute(event.userId);
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al obtener las solicitudes históricas');
      }
    } else if (event is GetByCaretakerId) {
      try {
        final requests = await getByCaretakerIdUseCase.execute(event.caretakerId);
        yield RequestLoaded(requests);
      } catch (e) {
        yield RequestError('Error al obtener las solicitudes por ID de cuidador');
      }
    }
  }
}