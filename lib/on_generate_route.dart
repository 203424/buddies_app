import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/presentation/add_pet_page.dart';
import 'package:buddies_app/features/request/presentation/add_pet_to_services_page.dart';
import 'package:buddies_app/features/request/presentation/history_list_page.dart';
import 'package:buddies_app/features/request/presentation/request_form_page.dart';
import 'package:buddies_app/features/request/presentation/map/select_location_page.dart';
import 'package:buddies_app/features/request/presentation/service_in_progress_page.dart';
import 'package:buddies_app/features/request/presentation/services_list_page.dart';
import 'package:flutter/material.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Pages.addPetPage:
        {
          return routeBuilder(const AddPetPage());
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
      case Pages.selectLocationPage:
        {
          return routeBuilder(const SelectLocationPage());
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
