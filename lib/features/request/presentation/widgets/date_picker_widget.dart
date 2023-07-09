import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({super.key});

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ExpansionPanelList(
            elevation: 1,
            expandedHeaderPadding: const EdgeInsets.all(0),
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _isExpanded = !isExpanded;
              });
            },
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return const ListTile(
                    title: Text('Seleccionar fecha'),
                  );
                },
                body: _isExpanded
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: const CalendarWidget(),
                      )
                    : const SizedBox(),
                isExpanded: _isExpanded,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    void _onDaySelected(DateTime day, DateTime focusedDay) {
      today = day;
    }

    return TableCalendar(
      calendarStyle: const CalendarStyle(
        selectedDecoration:
            BoxDecoration(color: redColor, shape: BoxShape.circle),
      ),
      locale: "es_ES",
      rowHeight: 43.0,
      headerStyle:
          const HeaderStyle(formatButtonVisible: false, titleCentered: true),
      availableGestures: AvailableGestures.all,
      selectedDayPredicate: (day) => isSameDay(day, today),
      focusedDay: today,
      firstDay: today,
      lastDay: DateTime.utc(2023, 12, 31),
      onDaySelected: _onDaySelected,
    );
  }
}
