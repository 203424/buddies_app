import 'package:buddies_app/const.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';

class AddPetToServicesPage extends StatefulWidget {
  final List<Map<String, String>> markedPets;
  const AddPetToServicesPage({super.key, required this.markedPets});

  @override
  State<AddPetToServicesPage> createState() => _AddPetToServicesPageState();
}

class _AddPetToServicesPageState extends State<AddPetToServicesPage> {
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
  List<bool> selectedPets = [];

  int maxSelectedPets = 2;

  void markSelectedPets() {
    if (widget.markedPets.isEmpty) {
      selectedPets = List.filled(pets.length, false);
    } else {
      int indexUno = 0;
      for (int i = 0; i < pets.length; i++) {
        if (indexUno < widget.markedPets.length &&
            pets[i]['name'] == widget.markedPets[indexUno]['name']) {
          selectedPets.add(true);
          indexUno++;
        } else {
          selectedPets.add(false);
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    markSelectedPets();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: const Text(
          'Seleccionar mascotas',
          style: Font.pageTitleStyle,
        ),
        leading: GestureDetector(
          onTap: () => widget.markedPets.isNotEmpty
              ? Navigator.pop(context, widget.markedPets)
              : Navigator.pop(context),
          child: const Icon(
            Icons.close,
            color: black,
          ),
        ),
        iconTheme: const IconThemeData(size: 30.0),
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: () {
                List<Map<String, String>> selected = [];
                for (int i = 0; i < pets.length; i++) {
                  if (selectedPets[i]) {
                    selected.add(pets[i]);
                  }
                }
                Navigator.pop(context, selected);
              },
              child: const Icon(
                Icons.done,
                color: redColor,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CustomScrollView(slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            var pet = pets[index];
            return petCardToSelect(pet, index);
          }, childCount: pets.length)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0, top: 5.0),
              child: ButtonFormWidget(
                  onPressed: () {
                    Navigator.pushNamed(context, Pages.addPetPage);
                  },
                  text: 'Agregar mascota'),
            ),
          )
        ]),
      ),
    ));
  }

  Widget petCardToSelect(pet, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            if (selectedPets.where((selected) => selected).length >=
                    maxSelectedPets &&
                !selectedPets[index]) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                
                backgroundColor: redColor,
                content: Text(
                    'Solo se permiten seleccionar $maxSelectedPets mascotas.',
                    style: Font.textStyleBold(color: white, fontSize: 20)),
                duration: Duration(seconds: 2),
              ));
            } else {
              selectedPets[index] = !selectedPets[index];
            }
          });
        },
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
                          text: '${pet['name']} ',
                          style: Font.titleStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: '${pet['type']}  ${pet['breed']}',
                                style: Font.textStyle)
                          ]),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text('Raza ${pet['size']}', style: Font.textStyle)
                  ],
                ),
              ),
              selectedPets[index]
                  ? const Icon(
                      Icons.done,
                      color: black,
                      size: 30.0,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
