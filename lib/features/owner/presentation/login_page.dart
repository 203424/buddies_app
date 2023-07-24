import 'package:buddies_app/features/owner/presentation/main_page.dart';
import 'package:buddies_app/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:buddies_app/const.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    // Aquí implementaríamos la lógica para autenticar al usuario
    // usando los valores ingresados en el correo electrónico y contraseña.
    // Por ahora, simplemente naveguemos a la página principal (MainPage).

    // Utilizamos Navigator.push para navegar a la página MainPage.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BuddiesIcons.logoRounded(
              sizeIcon: 200.0,
              color: redColor,
            ),
            InputFormWidget(
              title: 'Usuario',
              controller: _emailController,

            ),
            const SizedBox(height: 16),
            InputFormWidget(
              title: 'Contraseña',

              controller: _passwordController,

            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Iniciar sesión'),
            ),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, backgroundColor: Colors.white, // Color del texto del botón
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Borde redondeado del botón
                ),
                padding: const EdgeInsets.symmetric(vertical: 12.0), // Espaciado vertical del contenido
              ),
              child: Container(
                width:300,
                height:20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      // decoration: BoxDecoration(color: Colors.blue),
                        child:
                        Image.network(
                            'http://pngimg.com/uploads/google/google_PNG19635.png',
                            width: 26.0, // Tamaño de la imagen reducido
                            height: 26.0, // Tamaño de la imagen reducido
                            fit:BoxFit.cover
                        )
                    ),
                    SizedBox(
                      width: 5.0,

                    ),
                    Text('Iniciar sesion con Google')
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}


