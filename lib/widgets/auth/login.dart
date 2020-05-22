import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/widgets/components/button.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/linked_text.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final VoidCallback onSignUpShow;
  final VoidCallback onForgottenShow;

  Login({
    Key key,
    @required this.onSignUpShow,
    @required this.onForgottenShow,
  }) : super(key: key);

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
                          controller: null,
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
                          controller: null,
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
                              // TODO login stuff
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
                  _googleButton(
                    () {},
                  ),
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

  Widget _googleButton(onTap) {
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
              onPressed: onTap,
            ),
          ],
        ),
        Spacer(),
      ],
    );
  }
}
