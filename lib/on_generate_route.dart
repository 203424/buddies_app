import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/pets/presentation/add_pet_page.dart';
import 'package:flutter/material.dart';

class OnGenerateRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case Pages.addPetPage: {
          return routeBuilder(const AddPetPage());
      }
      // case Pages.signInPage: {
      //   return routeBuilder();
      // }
      // case Pages.signUpPage: {
      //   return routeBuilder();
      // }
      default: {
        const NoPageFound();
      }
    }
    return null;
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
        title: Text("Page not found"),
      ),
      body: Center(child: Text("Page not found"),),
    );
  }
}