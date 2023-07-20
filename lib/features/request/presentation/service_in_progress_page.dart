import 'dart:async';

import 'package:buddies_app/const.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as googleMaps;
import 'package:url_launcher/url_launcher.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class ServiceInProgressPage extends StatefulWidget {
  final Map<String, dynamic> service;
  const ServiceInProgressPage({super.key, required this.service});

  @override
  State<ServiceInProgressPage> createState() => _ServiceInProgressPageState();
}

class _ServiceInProgressPageState extends State<ServiceInProgressPage> {
  final Completer<googleMaps.GoogleMapController> _controller = Completer();

  static const googleMaps.LatLng sourceLocation =
      googleMaps.LatLng(16.703837, -93.1711162);
  static const googleMaps.LatLng destination =
      googleMaps.LatLng(16.704463, -93.171241);

  List<googleMaps.LatLng> polylineCordinates = [];
  LocationData? currentLocation;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCordinates.add(
          googleMaps.LatLng(point.latitude, point.longitude),
        );
      }
    }
    setState(() {});
  }

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) => currentLocation = location);
  }

  @override
  void initState() {
    // getPolyPoints();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> paseador = {
      'name': 'Gabriel',
      'rating': 4.6,
      'cellphone': '+52-961-603-5773',
      'walks': 10,
      'registration_date': '2021-07-20 02:06:56'
    };

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: white,
          centerTitle: true,
          title: Column(
            children: [
              Text("${widget.service['name']}",
                  style: Font.textStyleBold(fontSize: 26.0, color: black)),
              Text("${widget.service['service']}", style: Font.pageTitleStyle)
            ],
          ),
          iconTheme: const IconThemeData(color: greyColor),
          shadowColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "Hora: ${formatTime(widget.service['time'])}",
                    style: Font.titleBoldStyle,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Estado: ",
                        style: Font.textStyleBold(color: black, fontSize: 18.0),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        "${widget.service['status']}",
                        style: Font.textStyle,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Container(
                        width: 12.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: widget.service['status'] == 'Activo'
                                ? greenColor
                                : widget.service['status'] == 'Por terminar'
                                    ? yellowColor
                                    : greyColor),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                child: widget.service['status'] == 'Pendiente'
                    ? const SizedBox(
                        height: 10.0,
                      )
                    // : currentLocation == null
                    //     ? const Center(
                    //         child: Text('Cargando vista previa'),
                    //       )
                    : Container(
                        height: MediaQuery.of(context).size.width - 20,
                        child: googleMaps.GoogleMap(
                          zoomGesturesEnabled: true,
                          scrollGesturesEnabled: true,
                          rotateGesturesEnabled: true,
                          initialCameraPosition: googleMaps.CameraPosition(
                              target: googleMaps.LatLng(sourceLocation.latitude,
                                  sourceLocation.longitude),
                              zoom: 15),
                          polylines: {
                            googleMaps.Polyline(
                              polylineId: const googleMaps.PolylineId('route'),
                              points: polylineCordinates,
                              color: redColor,
                              width: 6,
                            )
                          },
                          markers: {
                            googleMaps.Marker(
                                markerId: const googleMaps.MarkerId('source'),
                                position: googleMaps.LatLng(
                                    sourceLocation.latitude,
                                    sourceLocation.longitude)),
                            const googleMaps.Marker(
                                markerId: googleMaps.MarkerId('destination'),
                                position: destination)
                          },
                          onMapCreated: (mapController) {
                            _controller.complete(mapController);
                          },
                        ),
                      ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Cuidador',
                  style: Font.titleStyle,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: const Text(
                            'Esta opción aún se encuentra en desarrollo.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(inputGrey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: widget.service['status'] == 'Pendiente'
                    ? const Center(
                        heightFactor: 6.0,
                        child: Text(
                          'Estamos buscando al cuidador ideal para ti',
                          style: Font.textStyle,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  paseador['name'],
                                  style: Font.textStyleBold(
                                      fontSize: 18.0, color: black),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        final Uri cellphone = Uri.parse(
                                            "tel:${paseador['cellphone']}");
                                        launchUrl(cellphone);
                                      },
                                      icon: const Icon(
                                        Icons.phone,
                                        color: redColor,
                                        size: 35.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        final Uri whatsapp = Uri.parse(
                                            "https://wa.me/${paseador['cellphone'].toString().replaceAll(RegExp(r'[+ -]'), '')}");
                                        launchUrl(whatsapp,
                                            mode:
                                                LaunchMode.externalApplication);
                                      },
                                      icon: const Icon(
                                        FontAwesome.whatsapp,
                                        color: redColor,
                                        size: 35.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${paseador['walks']}\nPaseos",
                                  style: Font.textStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "${paseador['rating']}\nCalificación",
                                  style: Font.textStyle,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  calcularAntiguedadCuenta(
                                      paseador['registration_date']),
                                  style: Font.textStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
              ),
              // ButtonFormWidget(onPressed: () {}, text: 'Cancelar servicio')
            ],
          )),
        ),
      ),
    );
  }

  String formatTime(String dateTimeString) {
    //la hora es insignificante es solo para el formateo
    DateTime dateTime = DateTime.parse("2023-01-01 $dateTimeString");
    String formattedTime = DateFormat.Hm().format(dateTime);

    return formattedTime;
  }

  String calcularAntiguedadCuenta(String fechaRegistro) {
    DateTime fechaActual = DateTime.now();
    DateTime fechaRegistroDateTime = DateTime.parse(fechaRegistro);

    Duration diferencia = fechaActual.difference(fechaRegistroDateTime);

    int anios = diferencia.inDays ~/ 365;
    int meses = (diferencia.inDays % 365) ~/ 30;
    int dias = diferencia.inDays % 30;

    double antiguedadDecimal = anios + (meses / 12);

    if (anios >= 1) {
      if (antiguedadDecimal == 1.0) {
        return '1\naño';
      } else if (antiguedadDecimal.toString().contains('.') &&
          antiguedadDecimal.toString().split('.').last == '0') {
        return '${antiguedadDecimal.toInt()}\naños';
      } else {
        return '${antiguedadDecimal.toStringAsFixed(1)}\naños';
      }
    } else if (meses >= 1) {
      if (meses == 1) {
        if (dias == 1) {
          return '1 mes\n1 día';
        } else if (dias > 1) {
          return '1 mes\n$dias días';
        } else {
          return '1\nmes';
        }
      } else {
        if (dias == 1) {
          return '$meses meses\n1 día';
        } else if (dias > 1) {
          return '$meses meses\n$dias días';
        } else {
          return '$meses\nmeses';
        }
      }
    } else {
      return '>1\nmes';
    }
  }
}
