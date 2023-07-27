import 'dart:async';

import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/presentation/pet/pet_bloc.dart';
import 'package:buddies_app/features/request/domain/entities/request/request_entity.dart';
import 'package:buddies_app/features/request/presentation/request/request_bloc.dart';
import 'package:buddies_app/features/request/presentation/widgets/service_in_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../pets/domain/entities/pet/pet_entity.dart';
import 'widgets/history_widget.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  void initState() {
    super.initState();
    // Disparar el evento para obtener la lista de mascotas
    _fetchPetsWithDelay();
  }

  @override
  void dispose() {
    super.dispose();
    // _fetchPetsWithDelay();
  }

  Timer? _fetchPetsTimer;

  void _fetchPetsWithDelay() {
    _fetchPetsTimer = Timer(Duration(seconds: 1), () {
      context.read<PetBloc>().add(GetPetsEvent());
      context.read<RequestBloc>().add(GetAllRequestsEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: white,
          title: BuddiesIcons.logoRounded(sizeIcon: 50.0),
          shadowColor: Colors.transparent,
        ),
        body: BlocListener<RequestBloc, RequestState>(
          listener: (context, state) {
            if (state is CreateRequestEvent) {
              _fetchPetsWithDelay();
            }
          },
          child: BlocBuilder<RequestBloc, RequestState>(
            builder: (context, state) {
              if (state is RequestLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RequestLoadedState) {
                if (state.requests.isEmpty) {
                  // Aquí puedes llamar al evento GetAllRequestsEvent
                  BlocProvider.of<RequestBloc>(context)
                      .add(GetAllRequestsEvent());
                  // Puedes dejar el indicador de carga mientras esperas la respuesta
                  return Center(child: CircularProgressIndicator());
                } else {
                  final List<RequestEntity> requests = state.requests;
                  return _buildRequestPageWidget(context, requests);
                }
              } else if (state is RequestErrorState) {
                return Center(child: Text(state.message));
              } else {
                return _buildRequestPageWidget(context, []);
              }
            },
          ),
        ),
      ),
    );
  }

  List<PetEntity> getAllPets(BuildContext context) {
    final petBloc = context.read<PetBloc>();
    petBloc.add(
        GetPetsEvent()); // Disparar el evento para obtener todas las mascotas
    final state = petBloc.state;
    if (state is PetLoadedState) {
      return state.pets;
    } else {
      return [];
    }
  }

  String getAllPetsById(BuildContext context, List<int> ids) {
    final petBloc = context.read<PetBloc>();
    // Disparar el evento para obtener mascotas por su ID
    petBloc.add(GetPetsByIdEvent(petsId: ids));

    final state = petBloc.state;
    if (state is PetLoadedState) {
      final List<PetEntity> allPets = state.pets;

      // Filtrar las mascotas por los ids proporcionados
      final List<PetEntity> petsById =
          allPets.where((pet) => ids.contains(pet.id)).toList();

      if (petsById.isNotEmpty) {
        // Si hay mascotas con los ids proporcionados, combinamos los nombres en una cadena separada por ' - '
        String combinedNames = petsById.map((pet) => pet.name).join(' - ');
        return combinedNames;
      } else {
        // Si no se encontraron mascotas con los ids proporcionados, devolvemos un mensaje de error o una cadena vacía
        return 'Error de mascota';
      }
    } else {
      return 'No se encontraron listas';
    }
  }

  Widget _buildRequestPageWidget(
      BuildContext context, List<RequestEntity> requests) {
    List<Map<String, String>> newList = [];
    List<Map<String, dynamic>> finalized = [];

// Verificar la longitud de ambas listas (listPetsId y requests) para determinar el tamaño de la nueva lista
    int maxLength = requests.length;

// Recorrer ambas listas y generar los objetos para la nueva lista
    for (int i = 0; i < maxLength; i++) {
      String name = i < requests.length
          ? getAllPetsById(context, requests[i].pet_id ?? []) ?? ' ' : '';
      String service = i < requests.length ? requests[i].type ?? ' ' : '';
      String time = i < requests.length ? requests[i].hour ?? ' ' : '';
      String status = i < requests.length ? requests[i].status ?? ' ' : '';
      String date = i < requests.length ? requests[i].start_date ?? ' ' : '';
      double cost = i < requests.length ? requests[i].cost ?? 0 : 0;

      Map<String, String> newObject = {
        'name': name, //Nombre de la mascota
        'date': date, //fecha en la que se pidio el servicio
        'time': time, //hora programada
        'service': service, //servicio que se da
        'status': status, // Estado del servicio
      };

      Map<String, dynamic> finalizedObject = {
        'name': name, //Nombre de la mascota
        'date': date, //fecha en la que se pidio el servicio
        'service': service, //servicio que se da
        'price': cost, // Estado del servicio
      };

      newList.add(newObject);
      if (status == 'Finalizado') {
        finalized.add(finalizedObject);
      }
    }

// Imprimir la nueva lista generada

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1.0,
                children: [
                  botonServicio(
                    context: context,
                    title: 'Paseo',
                    page: Pages.requestFormPage,
                    icon: BuddiesIcons.paseoIcon(
                        sizeIcon: 100.0, color: primaryColor),
                  ),
                  botonServicio(
                    context: context,
                    page: Pages.requestFormPage,
                    title: 'Hospedaje',
                    icon: BuddiesIcons.serviciosIcon(
                        sizeIcon: 100.0, color: primaryColor),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Servicios en curso",
                    style: Font.titleStyle,
                  ),
                  newList.length > 3
                      ? TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Pages.servicesListPage,
                              arguments: {'list': newList},
                            );
                          },
                          child: Text(
                            "Ver todos",
                            style: Font.textStyleBold(color: redColor),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final service = newList[index];
                return ServiceInProgressWidget(service: service);
              },
              childCount: newList.length > 3 ? 3 : newList.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Historial",
                    style: Font.titleStyle,
                  ),
                  finalized.length > 3
                      ? TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              Pages.historyListPage,
                              arguments: {'list': finalized},
                            );
                          },
                          child: Text(
                            "Ver todos",
                            style: Font.textStyleBold(color: redColor),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                final entry = finalized[index];
                return HistoryWidget(history: entry);
              },
              childCount: finalized.length > 3 ? 3 : finalized.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget botonServicio({
    String? title,
    SvgPicture? icon,
    required String page,
    required BuildContext context,
  }) {
    return ElevatedButton(
      onPressed: () =>
          Navigator.pushNamed(context, page, arguments: {'title': title}),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(inputGrey),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(color: redColor, width: 2.0),
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title!,
            style: Font.titleStyle,
          ),
          icon!,
        ],
      ),
    );
  }
}
