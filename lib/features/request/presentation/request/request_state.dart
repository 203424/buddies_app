part of 'request_bloc.dart';

abstract class RequestState {}
class RequestEmptyState extends RequestState {}

class RequestInitialState extends RequestState {}

class RequestLoadingState extends RequestState {}

class RequestLoadedState extends RequestState {
  final List<RequestEntity> requests;

  RequestLoadedState(this.requests);
}

class RequestSuccessState extends RequestState {
  final String successMessage;

  RequestSuccessState(this.successMessage);
}

class RequestErrorState extends RequestState {
  final String message;

  RequestErrorState(this.message);
}

class RequestCreatedState extends RequestState{
  RequestEntity requestEntity;

  RequestCreatedState(this.requestEntity);
}

class RequestUpdatedState extends RequestState{
  RequestEntity requestEntity;

  RequestUpdatedState(this.requestEntity);
}

class RequestDeletedState extends RequestState{
  int id;

  RequestDeletedState(this.id);
}


class RequestGetState extends RequestState{
  int id;

  RequestGetState(this.id);
}




class RequestStatusState extends RequestState{
  final String status;

  RequestStatusState(this.status);
}
