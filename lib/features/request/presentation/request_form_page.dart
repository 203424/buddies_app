import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/request/presentation/widgets/date_picker_widget.dart';
import 'package:buddies_app/features/request/presentation/widgets/simple_pet_card.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class RequestFormPage extends StatefulWidget {
  final String title;
  const RequestFormPage({super.key, required this.title});

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  bool _isValidTime = true;
  late DateTime selectedDate;
  String selectedLocation = '';
  int _paymentMethod = 0;
  Position? myPosition;

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

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _isValidTime = _isTimeWithinRange(_selectedTime);
  }

  bool _isTimeWithinRange(TimeOfDay time) {
    final int pickedMinutes = time.hour * 60 + time.minute;
    return pickedMinutes >= 7 * 60 && pickedMinutes <= 19 * 60;
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay now = TimeOfDay.now();
    TimeOfDay? pickedTime;

    pickedTime = await showTimePicker(
      context: context,
      initialTime: (selectedDate.year == DateTime.now().year &&
              selectedDate.month == DateTime.now().month &&
              selectedDate.day == DateTime.now().day)
          ? now
          : const TimeOfDay(hour: 7, minute: 0),
    );

    if (pickedTime != null) {
      final int pickedMinutes = pickedTime.hour * 60 + pickedTime.minute;
      final DateTime selectedDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      final DateTime currentDateTime = DateTime.now();
      const Duration margin = Duration(seconds: 30);

      if (selectedDateTime.isBefore(currentDateTime.subtract(margin))) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hora no válida'),
              content: const Text(
                  'No se puede seleccionar una hora anterior a la hora actual.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el diálogo
                  },
                ),
              ],
            );
          },
        );
      } else if (pickedMinutes < 7 * 60 || pickedMinutes > 19 * 60) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Hora no válida'),
              content: const Text(
                  'Solo se pueden seleccionar horas entre las 07:00 y las 19:00.'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); // Cerrar el diálogo
                  },
                ),
              ],
            );
          },
        );
      } else {
        _isValidTime = true;
        setState(() {
          _selectedTime = pickedTime!;
        });
      }
    }
  }

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
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text('Solicitar ${widget.title}', style: Font.pageTitleStyle),
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
                child: Text(
                  'Servicio',
                  style: Font.titleBoldStyle,
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ExpansionTile(
                          backgroundColor: inputGrey,
                          collapsedBackgroundColor: inputGrey,
                          leading: const Icon(Icons.calendar_today_outlined),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Fecha'),
                              Text(selectedDate.toString().substring(0, 10))
                            ],
                          ),
                          children: [
                            ListTile(
                              title: DatePickerWidget(
                                selectedDate: selectedDate,
                                onDateSelected: (date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        tileColor: inputGrey,
                        onTap: () {
                          _selectTime(context);
                        },
                        leading: const Icon(Icons.access_time),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Hora'),
                            if (_isValidTime)
                              Text(_selectedTime.format(context))
                            else
                              const Text('-- : --'),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        tileColor: inputGrey,
                        onTap: () {
                          Navigator.pushNamed(
                              context, Pages.selectLocationPage);
                        },
                        leading: const Icon(Icons.location_on_outlined),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ubicación'),
                            Text(
                              '(${myPosition?.latitude.toStringAsFixed(2)}, ${myPosition?.longitude.toStringAsFixed(2)})',
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Pago', style: Font.titleBoldStyle),
                    RadioListTile(
                      title: const Text('Efectivo'),
                      value: 0,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                    ),
                    RadioListTile(
                      title: const Text('Tarjeta'),
                      value: 1,
                      groupValue: _paymentMethod,
                      onChanged: (value) {
                        setState(() {
                          _paymentMethod = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: ButtonFormWidget(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: 'Enviar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
