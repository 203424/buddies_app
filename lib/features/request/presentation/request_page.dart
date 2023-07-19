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
    context.read<RequestBloc>().add(GetAllRequestsEvent());
    context.read<PetBloc>().add(GetPetsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: BuddiesIcons.logoRounded(sizeIcon: 50.0),
          shadowColor: Colors.transparent,
        ),
        body: BlocListener<RequestBloc, RequestState>(
      listener: (context, state) {
        if (state is CreateRequestEvent  ){

        }
      },
      child: BlocBuilder<RequestBloc, RequestState>(
        builder: (context, state) {
          if (state is RequestLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RequestLoadedState) {

            final List<RequestEntity> requests = state.requests;
            print(requests);

            return _buildRequestPageWidget(context, requests);
          } else if (state is RequestErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
      )
      ),
    );
  }


  @override
  Widget buildPet(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: white,
            title: BuddiesIcons.logoRounded(sizeIcon: 50.0),
            shadowColor: Colors.transparent,
          ),
          body: BlocListener<PetBloc, PetState>(
            listener: (context, state) {
              if (state is PetUpdatedState || state is PetCreatedState || state is PetDeletedState) {
              }
            },
            child: BlocBuilder<PetBloc, PetState>(
              builder: (context, state) {
                if (state is PetLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PetLoadedState) {
                  final List<PetEntity> pets = state.pets;
                  return null;
                } else if (state is PetErrorState) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return const SizedBox();
                }
              },
            ),
          )
      ),
    );
  }
  Widget _buildRequestPageWidget(BuildContext context, List<RequestEntity> requests ) {
    print(requests);

    List<Map<String, String>> servicesInProgress = [
      //lista de prueba
      {
        'name': 'Kira',
        'time': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'status': 'Por terminar',
      },
      {
        'name': 'Eevee',
        'time': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'status': 'Activo',
      },
      {
        'name': 'Manguito',
        'time': '2021-07-04 12:34:56',
        'service': 'Hospedaje - 3d',
        'status': 'Pendiente',
      },
      {
        'name': 'Kira',
        'time': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'status': 'Por terminar',
      },
    ];
    List<Map<String, dynamic>> history = [
      //lista de prueba

      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Kira',
        'date': '2021-07-04 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Eevee',
        'date': '2021-07-05 12:34:56',
        'service': 'Paseo individual - 1h',
        'price': 34,
      },
      {
        'name': 'Manguito',
        'date': '2021-07-06 12:34:56',
        'service': 'Hospedaje - 3d',
        'price': 250,
      },
      {
        'name': 'Manguito',
        'date': '2021-07-06 12:34:56',
        'service': 'Hospedaje - 3d',
        'price': 250,
      },
    ];
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
                    icon: BuddiesIcons.paseoIcon(sizeIcon: 100.0, color: primaryColor),
                  ),
                  botonServicio(
                    context: context,
                    page: Pages.requestFormPage,
                    title: 'Hospedaje',
                    icon: BuddiesIcons.serviciosIcon(sizeIcon: 100.0, color: primaryColor),
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
                  servicesInProgress.length > 3
                      ? TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Pages.servicesListPage,
                        arguments: {'list': servicesInProgress},
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
                final service = servicesInProgress[index];
                return ServiceInProgressWidget(service: service);
              },
              childCount: servicesInProgress.length > 3 ? 3 : servicesInProgress.length,
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
                  history.length > 3
                      ? TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Pages.historyListPage,
                        arguments: {'list': history},
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
                final entry = history[index];
                return HistoryWidget(history: entry);
              },
              childCount: history.length > 3 ? 3 : history.length,
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
      onPressed: () => Navigator.pushNamed(context, page, arguments: {'title': title}),
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