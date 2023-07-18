import 'dart:io';

class RequestEntity {
  final int? id;
  final String? type;
  final DateTime? start_date;
  final DateTime? end_date;
  final String? hour;
  final int? cost;
  final String? status;
  final List<int>? petId;
  final int? userId;
  final int? caretakerId;

  RequestEntity({
    this.id,
    this.type,
    this.start_date,
    this.end_date,
    this.hour,
    this.cost,
    this.status,
    this.petId,
    this.userId,
    this.caretakerId
  });
}
