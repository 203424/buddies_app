import 'package:buddies_app/const.dart';
import 'package:geolocator/geolocator.dart';
import 'package:buddies_app/features/request/presentation/map/map_controller.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class SelectLocationPage extends StatefulWidget {
  const SelectLocationPage({Key? key}) : super(key: key);

  @override
  State<SelectLocationPage> createState() => _SelectLocationPageState();
}

class _SelectLocationPageState extends State<SelectLocationPage> {
  final _controller = MapController();
  Marker? currentLocationMarker;
  final TextEditingController _searchController = TextEditingController();
  late CameraPosition initialPosition =
      const CameraPosition(target: LatLng(0, 0), zoom: 15);
  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  void initState() {
    super.initState();
    _getInitialPosition();
    getCurrentLocation();
  }

  Future<void> _getInitialPosition() async {
    try {
      Position position = await _controller.getCurrentPosition();
      setState(() {
        initialPosition = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 15,
        );

        currentLocationMarker = Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          anchor: const Offset(0.2, 0.2),
          infoWindow: const InfoWindow(title: 'Tu ubicación'),
        );

        _controller.markers.add(currentLocationMarker!);
      });
    } catch (error) {
      print('Error obtaining current position: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: myPosition == null
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  GoogleMap(
                    markers: _controller.markers,
                    initialCameraPosition: initialPosition,
                    myLocationButtonEnabled: true,
                    myLocationEnabled: true,
                    compassEnabled: false,
                    zoomControlsEnabled: false,
                    onTap: (argument) {
                      _controller.onTap(argument);
                      setState(() {}); //solo para recargar
                    },
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
                          onPressed: () {
                            Navigator.pop(context);
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
