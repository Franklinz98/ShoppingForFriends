import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/widgets/components/button.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/linked_text.dart';

class ForgottenPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final VoidCallback onLoginShow;
  final VoidCallback onBackPressed;

  ForgottenPassword({
    Key key,
    @required this.onLoginShow,
    @required this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: this.onBackPressed,
      child: Column(
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
                            height: 24.0,
                          ),
                          Button(
                            height: 48.0,
                            color: AppColors.cornflower_blue,
                            child: Text(
                              "Enviar correo",
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: LinkedText(
              text: "Iniciar Sesión",
              textStyle: GoogleFonts.roboto(
                fontSize: 14,
                color: AppColors.cornflower_blue,
              ),
              onTap: this.onLoginShow,
            ),
          ),
        ],
      ),
    );
  }
}
