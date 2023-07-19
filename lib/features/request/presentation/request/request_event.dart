part of 'request_bloc.dart';

@immutable
abstract class RequestEvent {}

class CreateRequest extends RequestEvent {
  final RequestEntity request;

  CreateRequest(this.request);
}

class UpdateRequest extends RequestEvent {
  final RequestEntity request;

  UpdateRequest(this.request);
}

class DeleteRequest extends RequestEvent {
  final int requestId;

  DeleteRequest(this.requestId);
}

class GetById extends RequestEvent {
  final int requestId;

  GetById(this.requestId);
}

class GetByUserId extends RequestEvent {
  final int userId;

  GetByUserId(this.userId);
}

class GetAllRequests extends RequestEvent {}

class GetByStatus extends RequestEvent {
  final String status;

  GetByStatus(this.status);
}

class GetInProgress extends RequestEvent {
  final int userId;

  GetInProgress(this.userId);
}

class GetHistory extends RequestEvent {
  final int userId;

  GetHistory(this.userId);
}

class GetByCaretakerId extends RequestEvent {
  final int caretakerId;

  GetByCaretakerId(this.caretakerId);
}












