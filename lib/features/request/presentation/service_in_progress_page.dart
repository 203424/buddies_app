import 'dart:async';

import 'package:buddies_app/const.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(16.703837, -93.1711162);
  static const LatLng destination = LatLng(16.704463, -93.171241);

  List<LatLng> polylineCordinates = [];
  LocationData? currentLocation;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Config.apiKey,
      PointLatLng(
          sourceLocation.latitude, sourceLocation.longitude), //inicio (dueño)
      PointLatLng(destination.latitude, destination.longitude), //fin (cuidador)
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      }
    }

    setState(() {});
  }

  void getCurrentLocation() {
    Location location = Location();

    location.getLocation().then((location) => {currentLocation = location});
  }

  @override
  void initState() {
    // getPolyPoints();
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.service);
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
                                    : widget.service['status'] == 'Pendiente'
                                        ? greyColor
                                        : redColor),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                child: widget.service['status'] == 'Pendiente' ||
                        widget.service['status'] == 'Por Pagar'
                    ? const SizedBox(
                        height: 10.0,
                      )
                    : Container(
                        height: MediaQuery.of(context).size.width - 20,
                        child: GoogleMap(
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(sourceLocation.latitude,
                                  sourceLocation.longitude),
                              zoom: 15),
                          markers: {
                            const Marker(
                                markerId: MarkerId('destination'),
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
              carerCard(context, paseador),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  'Detalles de pago',
                  style: Font.titleStyle,
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(inputGrey),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Método de pago",
                              style: Font.textStyle,
                            ),
                            Text(
                              "Monto",
                              style: Font.textStyle,
                            ),
                          ],
                        ),
                        Divider(
                          color: greyColor,
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Efectivo",
                              style: Font.textStyle,
                            ),
                            Text(
                              "\$${widget.service['price'] ?? 0}.00",
                              style: Font.numberStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          )),
        ),
        floatingActionButton: widget.service['status'] == 'Pendiente' ||
                widget.service['status'] == 'Por Pagar'
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ButtonFormWidget(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: widget.service['status'] == 'Por Pagar'
                        ? 'Pagar' //deberia mandar a una vista del monto a pagar
                        : 'Cancelar servicio'), //elimina el request
              )
            : const SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  String formatTime(String dateTimeString) {
    //la hora es insignificante es solo para el formateo
    DateTime dateTime = DateTime.parse("2023-01-01 $dateTimeString");
    String formattedTime = DateFormat.Hm().format(dateTime);
    return formattedTime;
  }

  ElevatedButton carerCard(
      BuildContext context, Map<String, dynamic> paseador) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content:
                  const Text('Esta opción aún se encuentra en desarrollo.'),
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
                        style: Font.textStyleBold(fontSize: 18.0, color: black),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              final Uri cellphone =
                                  Uri.parse("tel:${paseador['cellphone']}");
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
                                  mode: LaunchMode.externalApplication);
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
                  const Divider(
                    color: greyColorStatusBar,
                    height: 1,
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
                        calcularAntiguedadCuenta(paseador['registration_date']),
                        style: Font.textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
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
