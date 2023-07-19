import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class ServiceInProgressPage extends StatelessWidget {
  final Map<String, dynamic> service;
  const ServiceInProgressPage({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: white,
          centerTitle: true,
          title: Column(
            children: [
              Text("${service['name']}",
                  style: Font.textStyleBold(fontSize: 26.0, color: black)),
              Text("${service['service']}", style: Font.pageTitleStyle)
            ],
          ),
          iconTheme: const IconThemeData(color: greyColor),
          shadowColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: Column(children: [
                Text(
                  "Hora: ${formatTime(service['time'])}",
                  style: Font.titleBoldStyle,
                ),
                Row(
                  children: [
                    Text(
                      "Estado: ${service['status']}",
                      style: Font.textStyleBold(color: black, fontSize: 20.0),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Container(
                      width: 14.0,
                      height: 14.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: service['status'] == 'Activo'
                              ? greenColor
                              : service['status'] == 'Por terminar'
                                  ? yellowColor
                                  : greyColor),
                    )
                  ],
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }

  String formatTime(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    return formattedTime;
  }
}
