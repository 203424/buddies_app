import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';

class RequestModel extends RequestEntity {
  RequestModel({
    int? id,
    String? type,
    String? start_date,
    String? end_date,
    String? hour,
    int? cost,
    String? status,
    List<int>? pet_id,
    int? user_id,
    int? caretaker_id,
  }) : super(
            id: id,
            type: type,
            start_date: start_date,
            end_date: end_date,
            hour: hour,
            cost: cost,
            status: status,
            pet_id: pet_id,
            user_id: user_id,
            caretaker_id: caretaker_id);

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      type: json['type'],
      start_date: json['start_date'],
      end_date: json['end_date'],
      hour: json['hour'],
      cost: json['cost'],
      status: json['status'],
      pet_id: json['pet_id'] != null
          ? List<int>.from(json['pet_id']) // Convierte el valor a List<int>? si no es nulo
          : null, // Si es nulo, deja pet_id como null
      user_id: json['user_id'], // Si user_id también es un entero, utiliza int? aquí
      caretaker_id: json['caretaker_id'], // Si caretaker_id también es un entero, utiliza int? aquí
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
      pet_id  : request.pet_id,
      user_id: request.user_id,
      caretaker_id: request.caretaker_id,
    );
  }
}
