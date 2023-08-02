import 'package:buddies_app/const.dart';
import 'package:buddies_app/features/owner/presentation/login_page.dart';
import 'package:buddies_app/features/owner/presentation/owner/owner_bloc.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/text_button_account_widget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  var ownerBloc;

  @override
  void initState() {
    super.initState();
    ownerBloc = context.read<OwnerBloc>();
  }

  Future<dynamic> _confirmDeleteAccount(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: RichText(
            text: TextSpan(
              style: Font.textStyleBold(color: black, fontSize: 16),
              children: [
                const TextSpan(text: '¿Estas seguro de eliminar '),
                TextSpan(
                  text: 'permanentemente',
                  style: Font.textStyleBold(color: redColor, fontSize: 16),
                ),
                const TextSpan(text: ' tu cuenta?'),
              ],
            ),
          ),
          content: const Text("Esta acción no se puede revertir"),
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
                ownerBloc.add(DeleteOwnerEvent());
                print("delete button");
              },
            ),
          ],
        );
      },
    );
  }

  void deleteSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('id');
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      // padding: EdgeInsets.all(20.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(
            200.0), // Ajusta el radio para que parezca un óvalo
      ),
      content: Text(
        message,
        style: Font.textStyleBold(fontSize: 16.0),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  Map<String, dynamic> user = {
    "id": 1,
    "name": "Gabriel",
    "email": "gabriel@gmail.com",
    "password": "gabriel26!",
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: BlocListener<OwnerBloc, OwnerState>(
          listener: ((context, state) {
            print(state.toString());
            if (state is OwnerDeleted) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
              showSnackBar(context, "SESIÓN EXPIRADA");
            } else if (state is OwnerErrorState) {
              showSnackBar(context, state.errorMessage);
            }
          }),
          child: BlocBuilder<OwnerBloc, OwnerState>(
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return options(context);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget options(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 5.0),
            child: TextButtonAccountWidget(
              texto: "Quiero formar parte de Buddies",
              onPressed: () {},
              mostrarBorde: false,
              redondearSuperior: true,
              redondearInferior: true,
              disabledButton: true,
            ),
          )),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "Perfil",
                style: Font.titleStyle,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 5.0,
                ),
                TextButtonAccountWidget(
                  texto: "Mis datos",
                  disabledButton: true,
                  onPressed: () {
                    Navigator.pushNamed(context, Pages.accountFormPage,
                        arguments: {'user': user});
                  },
                  mostrarBorde: true,
                  redondearSuperior: true,
                  redondearInferior: false,
                ),
                TextButtonAccountWidget(
                  texto: "Cerrar sesión",
                  onPressed: () {
                    deleteSession();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                  mostrarBorde: true,
                  redondearSuperior: false,
                  redondearInferior: false,
                ),
                TextButtonAccountWidget(
                  texto: "Eliminar cuenta",
                  onPressed: () {
                    _confirmDeleteAccount(context);
                  },
                  colorText: redColor,
                  mostrarBorde: false,
                  redondearSuperior: false,
                  redondearInferior: true,
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: Text(
                "Sobre Buddies",
                style: Font.titleStyle,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(
                  height: 5.0,
                ),
                TextButtonAccountWidget(
                  texto: "Centro de atención",
                  onPressed: () {},
                  mostrarBorde: true,
                  redondearSuperior: true,
                  redondearInferior: false,
                  disabledButton: true,
                ),
                TextButtonAccountWidget(
                  texto: "Términos y condiciones",
                  onPressed: () {},
                  mostrarBorde: true,
                  redondearSuperior: false,
                  redondearInferior: false,
                  disabledButton: true,
                ),
                TextButtonAccountWidget(
                  disabledButton: true,
                  texto: "Aviso de privacidad",
                  onPressed: () {},
                  mostrarBorde: false,
                  redondearSuperior: false,
                  redondearInferior: true,
                ),
                const SizedBox(
                  height: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
