import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class ServiceInProgressWidget extends StatelessWidget {
  final Map<String, String> service;
  const ServiceInProgressWidget({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
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
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: const BoxDecoration(
                    color: primaryColor, shape: BoxShape.circle),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '${service['name']} ',
                          style: Font.titleStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: formatTime(service['time']!),
                                style: Font.textStyle)
                          ]),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text("${service['service']}", style: Font.textStyle)
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    '${service['status']}',
                    style: Font.textStyle,
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
            ],
          ),
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
