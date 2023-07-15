import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/presentation/add_pet_page.dart';
import 'package:buddies_app/features/request/presentation/add_pet_to_services_page.dart';
import 'package:buddies_app/features/request/presentation/history_list_page.dart';
import 'package:buddies_app/features/request/presentation/request_form_page.dart';
import 'package:buddies_app/features/request/presentation/service_in_progress_page.dart';
import 'package:buddies_app/features/request/presentation/services_list_page.dart';
import 'package:buddies_app/features/pets/presentation/update_pet_page.dart';

import 'package:flutter/material.dart';

import 'features/pets/domain/entities/pet/pet_entity.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Pages.addPetPage:
        {
          return routeBuilder(const AddPetPage());
        }
      case Pages.updatePetPage: // Agregamos la ruta updatePetPage
        {
          // Verificamos que los argumentos sean válidos antes de usarlos
          if (args is Map<String, dynamic>) {
            final petId = args['petId'] as int?;
            final petEntity = args['petEntity'] as PetEntity?;
            if (petId != null && petEntity != null) {
              return routeBuilder(UpdatePetPage(petId: petId, pet: petEntity));
            }
          }
          // En caso de que los argumentos no sean válidos o falten datos, puedes manejar el error o redirigir a una página de error.
          return null;
        }
      case Pages.requestFormPage:
        {
          args as Map<String, dynamic>;

          return routeBuilder(RequestFormPage(
            title: args['title'],
          ));
        }
      case Pages.addPetToServicesPage:
        {
          return routeBuilder(const AddPetToServicesPage());
        }
      case Pages.serviceInProgressPage:
        {
          return routeBuilder(const ServiceInProgressPage());
        }
      case Pages.servicesListPage:
        {
          return routeBuilder(const ServicesListPage());
        }
      case Pages.historyListPage:
        {
          return routeBuilder(const HistoryListPage());
        }
      default:
        {
          return routeBuilder(const NoPageFound());
        }
    }
  }
}

dynamic routeBuilder(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}

class NoPageFound extends StatelessWidget {
  const NoPageFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page not found"),
      ),
      body: const Center(
        child: Text("Page not found"),
      ),
    );
  }
}
