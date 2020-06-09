import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_for_friends/backend/firebase_auth.dart';
import 'package:shopping_for_friends/constants/colors.dart';
import 'package:shopping_for_friends/constants/enums.dart';
import 'package:shopping_for_friends/providers/content_provider.dart';
import 'package:shopping_for_friends/screens/main_container.dart';
import 'package:shopping_for_friends/widgets/components/button.dart';
import 'package:shopping_for_friends/widgets/components/input.dart';
import 'package:shopping_for_friends/widgets/components/linked_text.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final VoidCallback onLoginShow;
  final VoidCallback onBackPressed;
  final ContentProvider contentProvider;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUp({
    Key key,
    @required this.contentProvider,
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
                            "Nombre",
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
                                return 'Por favor ingrese su nombre';
                              }
                              return null;
                            },
                            controller: nameController,
                          ),
                          SizedBox(
                            height: 8.0,
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
                              "Registrarse",
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
                                _signUp(
                                  context,
                                  nameController.text,
                                  emailController.text,
                                  passwordController.text,
                                );
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "¿Tienes cuenta?",
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
                  text: "Iniciar Sesión",
                  textStyle: GoogleFonts.roboto(
                    fontSize: 14,
                    color: AppColors.cornflower_blue,
                  ),
                  onTap: this.onLoginShow,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _signUp(BuildContext context, String name, String email, String password) {
    signUpWithFirebase(email, password, name).then((user) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<ContentProvider>(
            create: (context) => contentProvider,
            child: MainContainer(
              loginType: LoginType.email,
              contentProvider: contentProvider,
              user: user,
            ),
          ),
        ),
      );
    }).catchError((error) {});
  }
}
