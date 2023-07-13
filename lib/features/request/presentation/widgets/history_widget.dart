import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';

class HistoryWidget extends StatelessWidget {
  final Map<String, dynamic> history;
  const HistoryWidget({super.key, required this.history});

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
                          text: '${history['name']}',
                          style: Font.titleStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: '  ${formatDate(history['date'])}',
                                style: Font.textStyle)
                          ]),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('${history['service']}', style: Font.textStyle)
                  ],
                ),
              ),
              Text(
                "\$${history['price']}.00",
                style: Font.numberStyle(
                    fontSize: 25.0, fontWeight: FontWeight.w900),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    final formattedDate =
        '${dateTime.day.toString().padLeft(2, '0')} ${_getMonthAbbreviation(dateTime.month)}';
    return formattedDate;
  }

  String _getMonthAbbreviation(int month) {
    const monthAbbreviations = [
      '',
      'ene.',
      'feb.',
      'mar.',
      'abr.',
      'may.',
      'jun.',
      'jul.',
      'ago.',
      'sep.',
      'oct.',
      'nov.',
      'dic.'
    ];
    return monthAbbreviations[month];
  }
}
