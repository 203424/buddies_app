import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/request/presentation/widgets/date_picker_widget.dart';
import 'package:buddies_app/features/request/presentation/widgets/simple_pet_card.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RequestFormPage extends StatelessWidget {
  final String title;
  const RequestFormPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var pet;
    List<Map<String, String>> pets = [
      //lista de prueba
      {
        'name': '1Kira',
        'birth': '2021-01-04 12:34:56',
        'type': 'Perro',
        'breed': 'Pastor',
        'size': 'Mediana',
      },
      {
        'name': '2Eevee',
        'birth': '2019-07-04 12:34:56',
        'type': 'Perro',
        'breed': 'Salchicha',
        'size': 'Pequeño',
      },
      {
        'name': '3Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '4Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '5Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '6Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '7Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '8Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '9Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '10Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '11Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
      {
        'name': '12Manguito',
        'birth': '2021-07-04 12:34:56',
        'type': 'Gato',
        'breed': 'Siamés',
        'size': 'Mediana',
      },
    ];
    return SafeArea(
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            title: Text('Solicitar ${title}', style: Font.pageTitleStyle),
            shadowColor: const Color.fromARGB(0, 214, 58, 58),
            iconTheme: const IconThemeData(color: black),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Mascota', style: Font.titleBoldStyle),
                      const Text('Puedes agregar como máximo 2 mascotas',
                          style: Font.textStyle),
                      const SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Pages.addPetToServicesPage);
                        },
                        child: const Column(
                          children: [
                            CircleAvatar(
                                backgroundColor: greyColor,
                                radius: 30,
                                child: Icon(
                                  Icons.add,
                                  color: white,
                                )),
                            Text(
                              'Agregar',
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      pet = pets[index];
                      return SimplePetCard(
                          name: pet['name'],
                          type: pet['type'],
                          breed: pet['breed'],
                          size: pet['size']);
                    },
                    childCount: 2,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Servicio',
                        style: Font.titleBoldStyle,
                      ),
                      DatePicker()
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: ExpansionTile(
        backgroundColor: inputGrey,
        collapsedBackgroundColor: inputGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Icon(Icons.date_range),
                SizedBox(
                  width: 10.0,
                ),
                Text('Fecha'),
              ],
            ),
            Text(today.toString().split(' ')[0]),
          ],
        ),
        children: [
          ListTile(
              title: TableCalendar(
            calendarStyle: const CalendarStyle(
              todayTextStyle: TextStyle(color: black),
              todayDecoration: BoxDecoration(color: Colors.transparent),
              selectedDecoration:
                  BoxDecoration(color: redColor, shape: BoxShape.circle),
            ),
            locale: "es_ES",
            rowHeight: 43.0,
            headerStyle: const HeaderStyle(
                formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            firstDay: DateTime.now(),
            lastDay: DateTime.utc(2023, 12, 31),
            onDaySelected: _onDaySelected,
          ))
        ],
      ),
    );
  }
}
