import 'package:buddies_app/const.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final DateTime minSelectableDate; // Nueva propiedad para la fecha mínima seleccionable.

  const DatePickerWidget({
    Key? key,
    required this.selectedDate,
    required this.onDateSelected,
    required this.minSelectableDate, // Incluir la nueva propiedad en el constructor.
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerWidget> {
  late DateTime today;

  @override
  void initState() {
    super.initState();
    today = widget.selectedDate;
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    // Verificar si el día seleccionado es posterior o igual a la fecha mínima seleccionable.
    if (day.isAfter(widget.minSelectableDate) || isSameDay(day, widget.minSelectableDate)) {
      setState(() {
        today = day;
      });
      widget.onDateSelected(day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarStyle: const CalendarStyle(
        todayTextStyle: TextStyle(color: black),
        todayDecoration: BoxDecoration(color: Colors.transparent),
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
      firstDay: widget.minSelectableDate, // Usar la fecha mínima seleccionable como primer día.
      lastDay: DateTime.utc(2023, 12, 31),
      onDaySelected: _onDaySelected,
    );
  }
}