import 'package:crud_sheety/UI/general/general.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:crud_sheety/UI/pagesModules/pagina_datatable.dart';
import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/service/user_provider.dart';
import 'package:crud_sheety/utils/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isVisible = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isLoading = true;
  //
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<RecursosProvider>(context, listen: true);
    final List<User> users = userProvider.recursoList;
    final size = MediaQuery.of(context).size;

    String userCorrecto;
    String passwordcorecto;

    void login() {
      FormState? formState = formkey.currentState!;
      if (formState.validate()) {
        formState.save();
        for (int i = 0; i < users.length; i++) {
          userCorrecto = users[i].dni.toString();
          passwordcorecto = users[i].password;

          if (userCorrecto.toLowerCase() == username.toLowerCase() &&
              passwordcorecto == password) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const MyDataTable()),
                (route) => false);
            // switch (users[i].role) {
            //   case 'admin':

            //     break;
            //   default:
            // }
          }
        }
      } else {
        !isLoading;
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor:
                const Color.fromARGB(255, 175, 59, 33).withOpacity(.8),
            content: Row(
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.white,
                ),
                spacingwidth10,
                const Text(
                  "Ha ocurrido un error, intentalo nuevamente.",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            )));
      }
    }

    return Scaffold(
      // backgroundColor: Colors.white,
      body: isLoading == true
          ? Form(
              key: formkey,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                     
                      height: MediaQuery.of(context).size.height,
                      constraints: const BoxConstraints(maxWidth: 400, minWidth: 300),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const H1(text: 'Área de Operaciones de Tasaciones', ),
                          spacingheight10,
                           const H1(text: 'Documento de Identidad', fontSize: 13, ),
                    
                          TextFormField(
                            style: TextStyle(
                                color: kfontPrimaryColor, fontSize: 12),
                            decoration: decorationinputtext(
                                'Ingresa tu DNI', 'Ingresa tu DNI'),
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            inputFormatters: [
                              //Expresion Regular
                              FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                            ],
                            onSaved: (values) {
                              username = values!;
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              if (value!.length < 8) {
                                return 'Ingrese 8 digitos';
                              }
                              return null;
                            },
                          ),
                          spacingheight10,
                           const H1(text: 'Contraseña de usuario', fontSize: 13, ),
                         
                          TextFormField(
                            obscureText: isVisible,
                            style: TextStyle(
                                color: kfontPrimaryColor, fontSize: 14),
                            decoration: InputDecoration(
                                hintText: 'Ingresa tu contraseña',
                                hintStyle: TextStyle(
                                  fontSize: 13,
                                  color: kfontPrimaryColor.withOpacity(.5),
                                ),
                                enabledBorder: outlineInputBorder(),
                                focusedBorder: outlineInputBorder(),
                                errorBorder: outlineInputBorder(),
                                border: outlineInputBorder(),
                                disabledBorder: outlineInputBorder(),
                                focusedErrorBorder: outlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      isVisible = !isVisible;
                                      setState(() {});
                                    },
                                    icon: Icon(
                                      isVisible != true
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 18,
                                      color: kfontPrimaryColor.withOpacity(.5),
                                    ))),
                            keyboardType: TextInputType.visiblePassword,
                            onSaved: (value) {
                              password = value!;
                            },
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Campo obligatorio';
                              }
                              if (value!.length < 6) {
                                return 'Ingrese mas de 6 caracteres';
                              }
                              return null;
                            },
                          ),
                          ButtonLogin(
                              onTap: () {
                                login();
                                setState(() {});
                                // print('Hola Login');
                              },
                              text: 'Iniciar sesión'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
