part of 'request_bloc.dart';

abstract class RequestEvent {}

class CreateRequestEvent extends RequestEvent {
  final RequestEntity request;

  CreateRequestEvent(this.request);
}

class UpdateRequestEvent extends RequestEvent {
  final RequestEntity request;

  UpdateRequestEvent(this.request);
}

class DeleteRequestEvent extends RequestEvent {
  final int requestId;

  DeleteRequestEvent(this.requestId);
}

class GetByIdEvent extends RequestEvent {
  final int requestId;

  GetByIdEvent(this.requestId);
}

class GetByUserIdEvent extends RequestEvent {
  final int userId;

  GetByUserIdEvent(this.userId);
}

class GetAllRequestsEvent extends RequestEvent {
  final int userId;

  GetAllRequestsEvent(this.userId);
}

class GetByStatusEvent extends RequestEvent {
  final String status;
  final int userId;

  GetByStatusEvent(this.status, this.userId);
}

class GetInProgressEvent extends RequestEvent {
  final int userId;

  GetInProgressEvent(this.userId);
}

class GetHistoryEvent extends RequestEvent {
  final int userId;

  GetHistoryEvent(this.userId);
}

class GetByCaretakerIdEvent extends RequestEvent {
  final int caretakerId;
  final int userId;

  GetByCaretakerIdEvent(this.caretakerId, this.userId);
}
