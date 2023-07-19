part of 'request_bloc.dart';

abstract class RequestState {}

class RequestInitial extends RequestState {}

class RequestLoading extends RequestState {}

class RequestLoaded extends RequestState {
  final List<RequestEntity> requests;

  RequestLoaded(this.requests);
}

class RequestError extends RequestState {
  final String message;

  RequestError(this.message);
}