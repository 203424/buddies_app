import 'dart:async';

import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/request/presentation/request/request_bloc.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buddies_app/features/pets/presentation/pet/pet_bloc.dart';
import 'package:buddies_app/features/pets/domain/entities/pet/pet_entity.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({Key? key}) : super(key: key);

  @override
  _PetsPageState createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  @override
  void initState() {
    super.initState();
    // Disparar el evento para obtener la lista de mascotas
    context.read<PetBloc>().add(GetPetsEvent());

  }

  Timer? _fetchPetsTimer;

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchPetsWithDelay() {
    _fetchPetsTimer = Timer(Duration(seconds: 1), () {
      context.read<PetBloc>().add(GetPetsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
            // Navegar a la página de agregar mascota
            Navigator.pushNamed(context, Pages.addPetPage);
          },
          backgroundColor: redColor,
          child: const Icon(Icons.add),
        ),
        body: BlocListener<PetBloc, PetState>(
          listener: (context, state) {
            if (state is PetUpdatedState ||
                state is PetCreatedState ||
                state is PetDeletedState) {
              _fetchPetsWithDelay();
            }
          },
          child: BlocBuilder<PetBloc, PetState>(
            builder: (context, state) {
              if (state is PetLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PetLoadedState) {
                final List<PetEntity> pets = state.pets;
                return _buildPetsList(pets);
              } else if (state is PetErrorState) {
                return Center(child: Text(state.errorMessage));
              } else {
                return const SizedBox();
              }
            },
          ),
        ));
  }

  Widget _buildPetsList(List<PetEntity> pets) {
    if (pets.isEmpty) {
      return Center(child: Text('No se encontraron mascotas'));
    }

    return ListView.builder(
      itemCount: pets.length,
      itemBuilder: (context, index) {
        final PetEntity pet = pets[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Acción al presionar el botón (esto se puede mantener si deseas mantener alguna acción aquí)
                  Navigator.pushNamed(
                    context,
                    Pages.updatePetPage,
                    arguments: {
                      'petId': pet.id,
                      'petEntity': pet,
                    },
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(inputGrey),
                ),
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
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5.0),
                            Text(
                              pet.name ?? '',
                              style: Font.titleStyle,
                            ),
                            const SizedBox(height: 25.0),
                            Row(
                              children: [
                                //Text(
                                //  '${calcularEdad(DateTime.parse(pet.birthday!))}',
                                //  style: Font.textStyle,
                                //),
                                const SizedBox(width: 20.0),
                                Text(
                                  '${pet.type ?? ''} ${pet.breed ?? ''}',
                                  style: Font.textStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              'Raza ${pet.size ?? ''}',
                              style: Font.textStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _openConfirmDeleteDialog(context, pet);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.backspace_outlined,
                    color: black,
                    size: 35.0,
                  ),
                ),
              ),
            ],
          ),
        );
      },
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

  Future<dynamic> _openConfirmDeleteDialog(
      BuildContext context, PetEntity pet) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar mascota'),
          content: RichText(
            text: TextSpan(
              style: Font.textStyle,
              children: [
                const TextSpan(text: '¿Desea eliminar el registro de '),
                TextSpan(
                  text: '${pet.name}',
                  style: Font.textStyleBold(color: black),
                ),
                const TextSpan(text: '?'),
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
              height: 40.0,
            ),
            TextButton(
              child: Text(
                'Confirmar',
                style: Font.textStyleBold(color: redColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<PetBloc>().add(DeletePetEvent(petId: pet.id ?? 0));
                // Disparar el evento para obtener la lista de mascotas actualizada después de eliminar una mascota
              },
            ),
          ],
        );
      },
    );
  }
}
