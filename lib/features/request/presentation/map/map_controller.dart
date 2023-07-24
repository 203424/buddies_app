import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController {
  final Map<MarkerId, Marker> _markers = {};
  GoogleMapController? mapController;
  LatLng? selectedLocation;

  Set<Marker> get markers => _markers.values.toSet();

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapTap(LatLng location) {
    selectedLocation = location;

    const markerId = MarkerId('selectedLocation');
    _markers[markerId] = Marker(
      markerId: const MarkerId('currentLocation'),
      position: selectedLocation!,
      infoWindow: const InfoWindow(title: 'Tu ubicación'),
    );
  }

  void moveCameraToLocation(CameraPosition location) {
    if (mapController != null) {
      mapController!.animateCamera(CameraUpdate.newCameraPosition(location));
    }
  }
}
