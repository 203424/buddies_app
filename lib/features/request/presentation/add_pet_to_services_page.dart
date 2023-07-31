import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/owner/presentation/owner/owner_bloc.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:buddies_app/features/pets/presentation/pet/pet_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../pets/domain/entities/pet/pet_entity.dart';

class AddPetToServicesPage extends StatefulWidget {
  final List<Map<String, dynamic>> markedPets;
  const AddPetToServicesPage({super.key, required this.markedPets});

  @override
  State<AddPetToServicesPage> createState() => _AddPetToServicesPageState();
}

class _AddPetToServicesPageState extends State<AddPetToServicesPage> {
  List<bool> selectedPets = [];
  List<Map<String, dynamic>> pets = [];
  int maxSelectedPets = 2;
  late int userId = 0;
  late var prefs;

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

  Future<void> getUserId() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt("id");
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PetBloc>().add(GetPetsByUserIdEvent(id: userId));
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
                List<Map<String, dynamic>> selected = [];
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
          BlocBuilder<PetBloc, PetState>(builder: (context, state) {
            pets = [];
            if (state is Loading) {
              return const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()));
            } else if (state is PetLoadedState) {
              for (var petE in state.pets) {
                pets.add({
                  'id': petE.id,
                  'name': petE.name,
                  'birthday': petE.birthday,
                  'type': petE.type,
                  'breed': petE.breed,
                  'gender': petE.gender,
                  'size': petE.size,
                  'description': petE.description,
                  'owner_id': petE.owner_id,
                });
              }
              markSelectedPets();
              return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                var pet = pets[index];
                return petCardToSelect(pet, index);
              }, childCount: pets.length));
            } else {
              return const SliverToBoxAdapter(
                child:
                    Center(child: Text('No tienes ninguna mascota registrada')),
              );
            }
          }),
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
                duration: const Duration(seconds: 2),
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
