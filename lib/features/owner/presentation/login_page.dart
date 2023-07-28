import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';
import 'package:buddies_app/features/owner/presentation/main_page.dart';
import 'package:buddies_app/features/owner/presentation/owner/owner_bloc.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:buddies_app/widgets/input_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:buddies_app/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ownerBloc = context.read<OwnerBloc>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: redColor,
        body: BlocBuilder<OwnerBloc, OwnerState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200.0,
                    width: 200.0,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(100.0)),
                    child: BuddiesIcons.logoRounded(
                      sizeIcon: 200.0,
                    ),
                  ),

                  // InputFormWidget(
                  //   title: 'Usuario',
                  //   controller: _emailController,
                  // ),
                  // const SizedBox(height: 16),
                  // InputFormWidget(
                  //   title: 'Contraseña',
                  //   controller: _passwordController,
                  // ),
                  // const SizedBox(height: 24),
                  // ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       foregroundColor: white,
                  //       backgroundColor: redColor, // Color del texto del botón
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(
                  //             10.0), // Borde redondeado del botón
                  //       ),
                  //       padding: const EdgeInsets.symmetric(
                  //           vertical: 20.0), // Espaciado vertical del contenido
                  //     ),
                  //     onPressed: _emailController.text.isEmpty ||
                  //             _passwordController.text.isEmpty
                  //         ? () {
                  //             print('vacios detected');
                  //             print(_emailController.text);
                  //             print(_passwordController.text);
                  //           }
                  //         : () {
                  //             final owner = OwnerEntity(
                  //                 id: 0,
                  //                 email: _emailController.text,
                  //                 password: _passwordController.text,
                  //                 name: '');
                  //             ownerBloc.add(CreateOwnerEvent(owner: owner));
                  //           },
                  //     child: const Text('Iniciar sesión')),
                  // SizedBox(
                  //   height: 10.0,
                  // ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        // signInWithGoogle();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainPage(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: black,
                        backgroundColor: inputGrey, // Color del texto del botón
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              8.0), // Borde redondeado del botón
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0), // Espaciado vertical del contenido
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                                // decoration: BoxDecoration(color: Colors.blue),
                                child: Image.network(
                                    'http://pngimg.com/uploads/google/google_PNG19635.png',
                                    width: 26.0, // Tamaño de la imagen reducido
                                    height:
                                        26.0, // Tamaño de la imagen reducido
                                    fit: BoxFit.cover)),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text('Iniciar sesion con Google')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
