import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';

class RequestModel extends RequestEntity {
  RequestModel({
    int? id,
    String? type,
    DateTime? start_date,
    DateTime? end_date,
    String? hour,
    int? cost,
    String? status,
    int? petId,
    int? userId,
  }) : super(
            id: id,
            type: type,
            start_date: start_date,
            end_date: end_date,
            hour: hour,
            cost: cost,
            status: status,
            petId: petId,
            userId: userId);

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      type: json['type'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      hour: json['hour'],
      cost: json['cost'],
      status: json['status'],
      petId: json['petId'],
      userId: json['userId'],
    );
  }

  factory RequestModel.fromEntity(RequestEntity request) {
    return RequestModel(
      id: request.id,
      type: request.type,
      start_date: request.start_date,
      end_date: request.end_date,
      hour: request.hour,
      cost: request.cost,
      status: request.status,
      petId: request.petId,
      userId: request.userId,

    );
  }
}
