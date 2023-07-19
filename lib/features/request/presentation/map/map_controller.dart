import 'package:flutter/gestures.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  Future<Position> getCurrentPosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permission denied');
      }
    }

    Position? position = await Geolocator.getCurrentPosition();
    return position!;
  }

  void onTap(LatLng position) {
    const markerId = MarkerId('currentLocation');
    final marker = Marker(
      markerId: markerId,
      position: position,
      anchor: const Offset(0.2, 0.2),
      infoWindow: const InfoWindow(title: 'Tu ubicación'),
    );

    _markers[markerId] = marker;
  }
}
