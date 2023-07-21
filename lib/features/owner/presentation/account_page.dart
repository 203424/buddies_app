import 'package:buddies_app/const.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/text_button_account_widget.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    //lista de prueba
    Map<String, dynamic> user = {
      "id": 1,
      "name": "Gabriel",
      "email": "gabriel@gmail.com",
      "password": "gabriel26!",
    };

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: Padding(
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
                      onPressed: () {},
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
                    ),
                    TextButtonAccountWidget(
                      texto: "Términos y condiciones",
                      onPressed: () {},
                      mostrarBorde: true,
                      redondearSuperior: false,
                      redondearInferior: false,
                    ),
                    TextButtonAccountWidget(
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
        ),
      ),
    );
  }

  Future<dynamic> _confirmDeleteAccount(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
