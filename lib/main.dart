import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/owner/presentation/login_page.dart';
// import 'package:buddies_app/features/owner/presentation/main_page.dart';
import 'package:buddies_app/features/request/presentation/request/request_bloc.dart';
import 'package:buddies_app/usecase_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:buddies_app/features/pets/presentation/pet/pet_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'on_generate_route.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initializeDateFormatting().then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: greyColorStatusBar),
    );

    final useCaseConfig = UseCaseConfig();
    final petBloc = PetBloc(
      getPetsUseCase: useCaseConfig.getPetsUseCase!,
      getPetsByIdUseCase: useCaseConfig.getPetsByIdUseCase!,
      deletePetUseCase: useCaseConfig.deletePetUseCase!,
      updatePetUseCase: useCaseConfig.updatePetUseCase!,
      createPetUseCase: useCaseConfig.createPetUseCase!,
    );

    final requestBloc = RequestBloc(
      createRequestUseCase: useCaseConfig.createRequestUseCase!,
      updateRequestUseCase: useCaseConfig.updateRequestUseCase!,
      deleteRequestUseCase: useCaseConfig.deleteRequestUseCase!,
      getByIdUseCase: useCaseConfig.getByIdUseCase!,
      getByUserIdUseCase: useCaseConfig.getByUserIdUseCase!,
      getAllRequestUseCase: useCaseConfig.getAllRequestUseCase!,
      getByStatusUseCase: useCaseConfig.getByStatusUseCase!,
      getInProgressUseCase: useCaseConfig.getInProgressUseCase!,
      getHistoryUseCase: useCaseConfig.getHistoryUseCase!,
      getByCaretakerIdUseCase: useCaseConfig.getByCaretakerIdUseCase!,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider<PetBloc>.value(value: petBloc),
        BlocProvider<RequestBloc>.value(value: requestBloc),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: OnGenerateRoute.route,
        theme: ThemeData(
          fontFamily: 'Montserrat',
          primarySwatch: redColorSwatch,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) {
            return LoginPage();
          },
        },
      ),
    );
  }
}
