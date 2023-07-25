import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/users/presentation/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'on_generate_route.dart';

void main() async{
  await dotenv.load(fileName: '.env');
  initializeDateFormatting().then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: greyColorStatusBar),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: OnGenerateRoute.route,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: redColorSwatch,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) {
          return const MainPage();
        }
      },
    );
  }
}
