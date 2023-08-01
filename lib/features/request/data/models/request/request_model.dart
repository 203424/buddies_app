import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RequestModel extends RequestEntity {
  RequestModel({
    int? id,
    String? type,
    String? start_date,
    String? end_date,
    String? hour,
    LatLng? location,
    double? cost,
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
            location: location,
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
      location: json['location'] != null
          ? LatLng(
        json['location'][1], // La latitud debe ser el segundo valor
        json['location'][0], // La longitud debe ser el primer valor
      )
          : null,
      cost: json['cost']?.toDouble(), // Parsea el valor como double si existe
      status: json['status'],
      pet_id: json['pet_id'] != null ? List<int>.from(json['pet_id']) : null,
      user_id: json['user_id'],
      caretaker_id: json['caretaker_id'],
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
