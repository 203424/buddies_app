import 'dart:io';

class RequestEntity {
  final int? id;
  final String? type;
  final DateTime? start_date;
  final DateTime? end_date;
  final String? hour;
  final int? cost;
  final String? status;
  final int? petId;
  final int? userId;

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
  });

  @override
  List<Object?> get props =>
      [id, type, start_date, end_date, hour, cost, status, petId, userId];
}
