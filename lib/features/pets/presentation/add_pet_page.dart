import 'package:buddies_app/const.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:buddies_app/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';

class AddPetPage extends StatelessWidget {
  const AddPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _birthController = TextEditingController();
    TextEditingController _typeController = TextEditingController();
    TextEditingController _breedController = TextEditingController();
    TextEditingController _genderController = TextEditingController();
    TextEditingController _descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Nueva mascota',
          style: Font.pageTitleStyle,
        ),
        shadowColor: Colors.transparent,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: SizedBox(
              width: 40.0,
              height: 30.0,
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: black,
                    size: 30.0,
                  )),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Container(
                  height: 150.0,
                  width: 150.0,
                  decoration: BoxDecoration(
                      color: inputGrey,
                      borderRadius: BorderRadius.circular(75.0)),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Cambiar foto de la mascota",
                  style: TextStyle(fontSize: 16.0, color: redColor),
                ),
              ),
            ),
            InputFormWidget(
              title: 'Nombre',
              controller: _nameController,
            ),
            InputFormWidget(
              title: 'Fecha de nacimiento',
              controller: _birthController,
            ),
            InputFormWidget(
              title: 'Tipo',
              controller: _typeController,
            ),
            InputFormWidget(
              title: 'Raza',
              controller: _breedController,
            ),
            InputFormWidget(
              title: 'Sexo',
              controller: _genderController,
            ),
            InputFormWidget(
              title: 'Describe a tu mascota',
              controller: _descriptionController,
              height: 100.0,
            ),
            ButtonFormWidget(
              onPressed: () {
                Navigator.pop(context);
              },
              text: 'Guardar',
              height: 50.0,
            )
          ]),
        ),
      ),
    );
  }
}
