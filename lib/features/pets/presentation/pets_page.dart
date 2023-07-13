import 'package:buddies_app/const.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';

class PetsPage extends StatelessWidget {
  const PetsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        'name': '3anguito',
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
          centerTitle: true,
          title: const Text(
            'Mascotas',
            style: Font.pageTitleStyle,
          ),
          shadowColor: Colors.transparent,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, Pages.addPetPage);
          },
          child: const Icon(Icons.add),
          backgroundColor: redColor,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final pet = pets[index];

                    return petCard(context, pet);
                  },
                  childCount: pets.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calcularEdad(DateTime fechaNacimiento) {
    DateTime fechaActual = DateTime.now();
    int edadAnios = fechaActual.year - fechaNacimiento.year;
    int edadMeses = fechaActual.month - fechaNacimiento.month;

    // Ajustar la edad en meses si la fecha actual es menor al mes de nacimiento
    if (fechaActual.month < fechaNacimiento.month) {
      edadAnios--;
      edadMeses = 12 - fechaNacimiento.month + fechaActual.month;
    }

    if (edadAnios < 1) {
      return '$edadMeses meses';
    } else {
      return '$edadAnios años';
    }
  }

  Widget petCard(context, pet) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Stack(alignment: Alignment.centerRight, children: [
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, Pages.addPetPage),
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              backgroundColor: const MaterialStatePropertyAll(inputGrey)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        '${pet['name'] ?? ''}',
                        style: Font.titleStyle,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        children: [
                          Text('${calcularEdad(DateTime.parse(pet['birth']))}',
                              style: Font.textStyle),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Text('${pet['type'] + ' ' + pet['breed'] ?? ''}',
                              style: Font.textStyle)
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text("Raza ${pet['size']}", style: Font.textStyle)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _openConfirmDeleteDialog(context, pet['name']);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(
              Icons.backspace_outlined,
              color: black,
              size: 35.0,
            ),
          ),
        )
      ]),
    );
  }

  Future<dynamic> _openConfirmDeleteDialog(context, pet) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Eliminar mascota',
            ),
            content: RichText(
              text: TextSpan(
                style: Font.textStyle,
                children: [
                  const TextSpan(text: '¿Desea eliminar el registro de '),
                  TextSpan(
                    text: '$pet',
                    style: Font.textStyleBold(color: black),
                  ),
                  const TextSpan(
                    text: '?',
                    style: Font.textStyle,
                  ),
                ],
              ),
            ),
            actions: [
              ButtonFormWidget(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: 'Cancelar',
                  width: 90.0,
                  height: 40.0),
              TextButton(
                child: Text(
                  'Confirmar',
                  style: Font.textStyleBold(color: redColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
