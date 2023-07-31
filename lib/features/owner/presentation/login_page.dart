import 'package:buddies_app/features/owner/domain/entities/owner_entity.dart';
import 'package:buddies_app/features/owner/presentation/main_page.dart';
import 'package:buddies_app/features/owner/presentation/owner/owner_bloc.dart';
import 'package:buddies_app/widgets/button_form_widget.dart';
import 'package:buddies_app/widgets/input_form_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:buddies_app/const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool registerForm = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    final ownerBloc = context.read<OwnerBloc>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocListener<OwnerBloc, OwnerState>(
              listener: ((context, state) {
                if (state is OwnerErrorState) {
                  showSnackBar(context, state.errorMessage);
                } else if (state is OwnerAuthenticated) {
                  Navigator.of(context).pushReplacementNamed(Pages.mainPage,
                      arguments: state.token);
                }
              }),
              child: BlocBuilder<OwnerBloc, OwnerState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      Container(
                        height: 200.0,
                        width: 200.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.0)),
                        child: BuddiesIcons.logoRounded(
                          sizeIcon: 200.0,
                        ),
                      ),
                      registerForm
                          ? InputFormWidget(
                              title: 'Nombre',
                              controller: _nameController,
                            )
                          : const SizedBox(),
                      InputFormWidget(
                        title: 'Email',
                        controller: _emailController,
                      ),
                      InputFormWidget(
                        title: 'Contraseña',
                        controller: _passwordController,
                        isInputPassword: true,
                      ),
                      const SizedBox(height: 24),
                      if (state is Loading)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else
                        registerForm
                            ? ButtonFormWidget(
                                onPressed: () {
                                  if (_nameController.text.isEmpty ||
                                      _emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    showSnackBar(context,
                                        'Los campos deben rellenarse.');
                                  } else {
                                    final owner = OwnerEntity(
                                        id: 0,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        name: _nameController.text);
                                    ownerBloc
                                        .add(CreateOwnerEvent(owner: owner));

                                    setState(() {
                                      registerForm = !registerForm;
                                      _nameController.text = '';
                                    });
                                  }
                                },
                                text: 'Guardar')
                            : ButtonFormWidget(
                                onPressed: () {
                                  _emailController.text.isEmpty ||
                                          _passwordController.text.isEmpty
                                      ? showSnackBar(context,
                                          'Los campos deben rellenarse.')
                                      : ownerBloc.add(
                                          SignInEvent(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text),
                                        );
                                },
                                text: 'Iniciar sesión'),
                      const SizedBox(
                        height: 10.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: registerForm
                              ? '¿Ya tienes cuenta? '
                              : '¿No tienes cuenta? ',
                          style: Font.textStyle,
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      registerForm = !registerForm;
                                    });
                                  },
                                text: registerForm
                                    ? 'Inicia sesión'
                                    : 'Registrate',
                                style: Font.textStyleBold(color: redColor))
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
