import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';
import 'package:buddies_app/features/pets/presentation/pet/pet_bloc.dart';

import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:buddies_app/widgets/input_form_widget.dart';
import 'package:buddies_app/widgets/date_picker_widget.dart';
import 'package:buddies_app/widgets/dropdown_picker_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/breed_picker_widget.dart';

class UpdatePetPage extends StatefulWidget {
  final int petId; // Se recibe el ID de la mascota que se va a actualizar
  final PetEntity
      pet; // Se recibe el objeto PetEntity con los datos de la mascota que se va a actualizar

  const UpdatePetPage({Key? key, required this.petId, required this.pet})
      : super(key: key);

  @override
  _UpdatePetPageState createState() => _UpdatePetPageState();
}

class _UpdatePetPageState extends State<UpdatePetPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Aquí puedes cargar los datos de la mascota que se va a actualizar utilizando widget.pet
    _nameController.text = widget.pet.name ?? '';
    _birthController.text = widget.pet.birthday ?? '';
    _typeController.text = widget.pet.type ?? '';
    _breedController.text = widget.pet.breed ?? '';
    _genderController.text = widget.pet.gender ?? '';
    _descriptionController.text = widget.pet.description ?? '';
    _sizeController.text = widget.pet.size ?? '';
    initConnectivity();
  }

  late int id = 0;
  void initConnectivity() async {
    final prefs = await SharedPreferences.getInstance();
    int? idverdadero = prefs.getInt("id");
    if (idverdadero != null) {
      setState(() {
        id = idverdadero!;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _typeController.dispose();
    _breedController.dispose();
    _genderController.dispose();
    _descriptionController.dispose();
    _sizeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        centerTitle: true,
        title: const Text(
          'Actualizar mascota',
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
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
            InputFormWidget(
            title: 'Nombre',
            controller: _nameController,
          ),
            DatePickerWidget(
              controller: _birthController,
            ),
            SizedBox(
              height: 15.0,
            ),
            DropdownPickerWidget(
              title: 'Tipo',
              value: _typeController.text,
              options: ['Perro', 'Gato'],
              onChanged: (newValue) {
                setState(() {
                  _typeController.text = newValue;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            DropdownPickerWidget(
                title: 'Tamaño',
                value: _sizeController.text,
                options: ['Pequeño', 'Mediano', 'Grande'],
                onChanged: (newValue) {
                  setState(() {
                    _sizeController.text = newValue;
                  });
                }),
            BreedPickerWidget(
              petType: _typeController.text.toLowerCase(),
              selectedBreed: _breedController.text,
              onChanged: (breed) {
                setState(() {
                  print(_breedController.text);

                  _breedController.text = breed;
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            DropdownPickerWidget(
              title: 'Sexo',
              value: _genderController.text,
              options: ['Macho', 'Hembra'],
              onChanged: (newValue) {
                setState(() {
                  _genderController.text = newValue;
                });
              },
            ),
            InputFormWidget(
              title: 'Describe a tu mascota',
              controller: _descriptionController,
              height: 100.0,
              isInputBlock: true,
            ),
              ButtonFormWidget(
                onPressed: () {
                  // Aquí puedes crear el objeto de la mascota con los datos actualizados
                  final updatedPet = PetEntity(
                    id: widget.petId,
                    name: _nameController.text,
                    birthday: _birthController.text,
                    type: _typeController.text,
                    breed: _breedController.text,
                    gender: _genderController.text,
                    size: _sizeController.text,
                    description: _descriptionController.text,
                    owner_id: id,
                  );
                  final updatedPetsList = [updatedPet];

                  // Crear la lista con el ID de la mascota que deseas actualizar
                  final petIdsList = [widget.petId];

                  // Disparar el evento para actualizar la mascota en el bloc
                  context.read<PetBloc>().add(UpdatePetEvent(                    pets: updatedPetsList,
                    petIds: petIdsList,
                  ));

                  Navigator.pop(context); // Regresar a la página anterior (PetsPage)
                },
                text: 'Guardar',
                height: 50.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
