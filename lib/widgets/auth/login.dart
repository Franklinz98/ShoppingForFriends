import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_for_friends/backend/firebase_auth.dart';
import 'package:shopping_for_friends/backend/google_auth.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/main_container.dart';
import 'package:shopping_for_friends/widgets/components/button.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/linked_text.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final VoidCallback onSignUpShow;
  final VoidCallback onForgottenShow;
  final ContentProvider contentProvider;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Login({
    Key key,
    @required this.contentProvider,
    @required this.onSignUpShow,
    @required this.onForgottenShow,
  }) : super(key: key);

  void _googleLogin(BuildContext context) async {
    signInWithGoogle().then((user) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<ContentProvider>(
            create: (context) => contentProvider,
            child: MainContainer(
              contentProvider: contentProvider,
              user: user,
            ),
          ),
        ),
      );
    }).catchError((error) {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Image.asset(
                            'assets/images/logo.png',
                            height: 84.0,
                          ),
                        ),
                        Text(
                          "Correo Electrónico",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.spun_pearl,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Input(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese su correo electrónico';
                            } else if (!value.contains('@')) {
                              return 'Por favor ingrese un correo electrónico válido';
                            }
                            return null;
                          },
                          controller: emailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "Contraseña",
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColors.spun_pearl,
                          ),
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Input(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese su contraseña';
                            } else if (value.length < 6) {
                              return 'La contraseña de tener al menos 6 caracteres';
                            }
                            return null;
                          },
                          controller: passwordController,
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Button(
                          height: 48.0,
                          color: AppColors.cornflower_blue,
                          child: Text(
                            "Iniciar Sesión",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color(0xffffffff),
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _login(
                                context,
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        LinkedText(
                          text: "¿Olvidaste tu contraseña?",
                          textStyle: GoogleFonts.roboto(
                            fontSize: 14,
                            color: AppColors.cornflower_blue,
                          ),
                          onTap: this.onForgottenShow,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 56.0,
                  ),
                  _googleButton(context),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "¿No tienes cuenta?",
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 8.0,
              ),
              LinkedText(
                text: "Registrarse",
                textStyle: GoogleFonts.roboto(
                  fontSize: 14,
                  color: AppColors.cornflower_blue,
                ),
                onTap: this.onSignUpShow,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _googleButton(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(),
        Column(
          children: <Widget>[
            Text(
              "Acceder con:",
              style: GoogleFonts.roboto(
                fontSize: 14,
                color: AppColors.spun_pearl,
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Button(
              height: 40.0,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/google_logo.png',
                    width: 18.0,
                    height: 18.0,
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  Text(
                    "GOOGLE",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xff000000).withOpacity(0.54),
                    ),
                  )
                ],
              ),
              onPressed: () => _googleLogin(context),
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }

  _login(BuildContext context, String email, String password) {
    signInWithFirebase(email, password).then((user) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<ContentProvider>(
            create: (context) => contentProvider,
            child: MainContainer(
              contentProvider: contentProvider,
              user: user,
            ),
          ),
        ),
      );
    }).catchError((error) {});
  }
}
