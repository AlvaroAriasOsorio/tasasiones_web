import 'package:crud_sheety/UI/general/general.dart';
import 'package:crud_sheety/UI/pages/nav_perfil_page.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:crud_sheety/UI/pagesModules/pagina_datatable.dart';
import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/service/user_provider.dart';
import 'package:crud_sheety/UI/widget/text_custom.dart';

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

    String userCorrecto;
    String passwordcorecto;

    void login() {
      FormState? formState = formkey.currentState!;
      if (formState.validate()) {
        formState.save();
        for (int i = 0; i < users.length; i++) {
          userCorrecto = users[i].dni.toString();
          passwordcorecto = users[i].password;
          if (users[i].estatus) {
            
              if (userCorrecto.toLowerCase() == username.toLowerCase() && passwordcorecto == password) {
              
                switch (users[i].role) {
                  case 'admin':
                      Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>  NavPerfilPage(index: i, listusers: userProvider,)), (route) => false);
                    break;
                  case 'usuario':
                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>  MyDataTable(index: i, listusers: userProvider,)), (route) => false);
                  //  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) =>  UsuariogestionPage()), (route) => false);
                  break;
                  default:
                }
              }
          } 
        }
      } else {
        !isLoading;
        setState(() {});
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: const Duration(seconds: 4), // Establece la duración del SnackBar
        content: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: const Text(
                "Ha ocurrido un error, intentalo nuevamente.\nConsulte al administrador el estado de su cuenta",
                style: TextStyle(fontSize: 12), // Ajusta el tamaño del texto según tus preferencias
              ),
            ),
          ],
        ),
      ));

      }
    }

    return Scaffold(
      body:  Form(
              key: formkey,
              child: Stack(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/background.jpeg'))
                    ),
                  ),
                  //  Align(
                  //    alignment: Alignment.bottomRight,
                  //    child: Lottie.asset(
                  //       'assets/Animation.json', 
                  //       fit: BoxFit.cover,
                  //     ),
                  //  ),
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
                                fillColor: Colors.white,
                                filled: true,
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
                              onTap: () => login(),
                              text: 'Iniciar sesión'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
    );
  }
}
