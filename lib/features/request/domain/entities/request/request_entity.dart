import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestEntity {
  final int? id;
  final String? type;
  final String? start_date;
  final String? end_date;
  final String? hour;
  final LatLng? location; // Agregar el campo para la ubicación
  final double? cost;
  final String? status;
  final List<int>? pet_id;
  final int? user_id;
  final int? caretaker_id;

  RequestEntity({
    this.id,
    this.type,
    this.start_date,
    this.end_date,
    this.hour,
    this.location,
    this.cost,
    this.status,
    this.pet_id,
    this.user_id,
    this.caretaker_id
  });
}
