import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:flutter/material.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  Widget build(BuildContext context) {
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
          onPressed: () {},
          child: const Icon(Icons.add),
          backgroundColor: redColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [petCard()]),
          ),
        ),
      ),
    );
  }

  Widget petCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
          color: inputGrey, borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kira',
                    style: Font.titleStyle,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      Text('2 años'),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Perro Pastor')
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Raza Mediana", style: Font.textStyle)
                ],
              ),
            ),
            const Icon(
              Icons.more_vert,
              color: black,
            )
          ],
        ),
      ),
    );
  }
}
