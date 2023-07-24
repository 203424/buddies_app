import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/request/presentation/map/map_controller.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class SelectLocationPage extends StatefulWidget {
  final LatLng? initialLocation;
  const SelectLocationPage({Key? key, required this.initialLocation})
      : super(key: key);

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final MapController _mapController = MapController();

  Marker? currentLocationMarker;
  final TextEditingController _searchController = TextEditingController();
  CameraPosition initialPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);
  Location location = Location();
  LocationData? currentLocation;
  StreamSubscription<LocationData>? locationSubscription;

  Future<void> _getLocation() async {
    try {
      var serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          return;
        }
      }

      var permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      LocationData currentLocationData = await location.getLocation();

      setState(() {
        currentLocation = currentLocationData;
        initialPosition = CameraPosition(
          target: widget.initialLocation!,
          zoom: 19.5,
        );
        _mapController.onMapTap(widget.initialLocation!);
      });
    } catch (e) {
      print("Error al obtener la ubicación: $e");
    }
  }

  void _moveToSelectedLocation() {
    if (_mapController.selectedLocation != null) {
      _mapController.moveCameraToLocation(CameraPosition(
        target: _mapController.selectedLocation!,
        zoom: 19.5,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _mapController.selectedLocation = widget.initialLocation;
    _getLocation();
  }

  @override
  void dispose() {
    super.dispose();
    locationSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: currentLocation == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    markers: _mapController.markers,
                    initialCameraPosition: initialPosition,
                    circles: {
                      Circle(
                          circleId: const CircleId('center'),
                          center: LatLng(currentLocation!.latitude ?? 0,
                              currentLocation!.longitude ?? 0),
                          radius: 0.25,
                          strokeColor: redColor,
                          fillColor: redColor),
                      Circle(
                          circleId: const CircleId('radius'),
                          center: LatLng(currentLocation!.latitude ?? 0,
                              currentLocation!.longitude ?? 0),
                          radius: 10,
                          strokeColor: redColor,
                          strokeWidth: 1,
                          fillColor: redColor.withOpacity(0.1))
                    },
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    onTap: (location) {
                      setState(() {
                        _mapController.onMapTap(location);
                      });
                      _moveToSelectedLocation();
                    },
                    onMapCreated: _mapController.onMapCreated,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          hintText: 'Buscar en el mapa',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: white,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80.0,
                    right: 10.0,
                    child: FloatingActionButton(
                      backgroundColor: redColorSwatch.shade300,
                      onPressed: () {
                        _mapController.moveCameraToLocation(CameraPosition(
                            target: LatLng(currentLocation!.latitude ?? 0,
                                currentLocation!.longitude ?? 0),zoom:19.5));
                        setState(() {
                          _mapController.onMapTap(LatLng(
                              currentLocation!.latitude ?? 0,
                              currentLocation!.longitude ?? 0));
                        });
                      },
                      child: const Icon(Icons.my_location),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ButtonFormWidget(
                          onPressed: _mapController.selectedLocation == null
                              ? () {}
                              : () {
                                  Navigator.pop(
                                      context, _mapController.selectedLocation);
                                },
                          text: 'Seleccionar esta ubicación'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
