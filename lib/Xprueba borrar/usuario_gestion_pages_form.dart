

import 'package:crud_sheety/UI/general/colors.dart';
import 'package:crud_sheety/UI/general/inputdecoration_form.dart';
import 'package:crud_sheety/UI/general/spaicing.dart';
import 'package:crud_sheety/UI/widget/card_blur_wdiget.dart';
import 'package:crud_sheety/UI/widget/text_custom.dart';
import 'package:crud_sheety/service/user_form_provider.dart';
import 'package:crud_sheety/service/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UsuarioModule extends StatelessWidget {
  const UsuarioModule({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark); //color de la barra de superior del phone
    //.copyWith( statusBarColor: Colors.redAccent, statusBarBrightness: Brightness.dark ));

    final userProvider = Provider.of<RecursosProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => UserFormProvider(userProvider.selectedUser),
      child: _ProductScreenBody(userProvider: userProvider),
    );
  }
}

class _ProductScreenBody extends StatefulWidget {
  const _ProductScreenBody({
    required this.userProvider,
  });

  final RecursosProvider userProvider;

  @override
  State<_ProductScreenBody> createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<_ProductScreenBody> {
  bool expandedimage = false;
  @override
  Widget build(BuildContext context) {
    final uForm = Provider.of<UserFormProvider>(context);

    return Scaffold(
      appBar: AppBar(leading: const BackButton(color: Colors.black,),backgroundColor: Colors.white,
      actions: [
          //Boton guardar Cambios
                  CircleAvatar(
                    backgroundColor: Colors.black.withOpacity(.2),
                    child: InkWell(
                      onTap: widget.userProvider.isaving
                          ? null
                          : () async {
                              //GUARDAR CMABIOS
                              if (!uForm.isValidation()) return;
                              final String? imageUrl =
                                  await widget.userProvider.uploadImage();
                              if (imageUrl != null) {
                                uForm.userform.image = imageUrl;
                              }
                              await widget.userProvider
                                  .saveOrCreateProduct(uForm.userform);

                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                      child: widget.userProvider.isaving
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.save,
                              color: Colors.black,
                            ),
                    ),
                  ),
                  spacingwidth20
      ],
      ),
      body: const SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: UsuariosFOrm(),
        ),
      ),
    );
  }
}

class UsuariosFOrm extends StatefulWidget {
  const UsuariosFOrm({super.key});
  @override
  State<UsuariosFOrm> createState() => _UsuariosFOrmState();
}

class _UsuariosFOrmState extends State<UsuariosFOrm> {
  bool isChecked = false;
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    final uForm = Provider.of<UserFormProvider>(context);
    final users = uForm.userform;
    List<String> genero = ['masculino', 'femenino'];
    List<String> roles = [
      'admin',
      'usuario',
    ];
    List<String> cargoPuesto = [
      'Gerente',
      'Administrador',
      'Contador',
      'Reservas',
      'Asistente operaciones',
      'Chofer',
      'otros'
    ];

    return BlurWidget(
      colorblur: Colors.black.withOpacity(.2),
      height: null,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        padding: const EdgeInsets.only(top: 30, left: 60, right: 20, bottom: 0),
        child: Form(
            key: uForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const H1(
                    fontSize: 18,
                    text: 'Datos de usuario',
                    textColor: Colors.black),
                spacingheight50,
                TextFormField(
                  initialValue: users.nombreCompleto,
                  onChanged: (value) => users.nombreCompleto = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  decoration:
                      decorationinputtext('Nombre del usuario', 'Nombre'),
                  keyboardType: TextInputType.text,
                ),
                spacingheight10,
                TextFormField(
                  initialValue: users.apellido,
                  onChanged: (value) {
                    users.apellido = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Apellidos de usuario', 'Apellidos'),
                ),
                spacingheight10,
                DropdownButtonFormField(
                    hint: Text(users.genero),
                    decoration: decorationinputtext('Ingresa genero', 'genero'),
                    items: genero
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      users.genero = value!;
                      isChecked = true;
                      // ignore: avoid_print
                      print(isChecked);

                      setState(() {});
                    }),
                spacingheight10,
                DropdownButtonFormField(
                    hint: Text(users.role),
                    decoration:
                        decorationinputtext('Ingresa rol', 'Rol de usuario'),
                    items: roles
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      users.role = value!;
                      isChecked = true;
                      setState(() {});
                    }),
                spacingheight10,
                TextFormField(
                  initialValue: users.id == null
                      ? '${users.dni}'.substring(
                          1,
                        )
                      : '${1}${users.dni}'.substring(
                          1,
                        ),
                  onChanged: (value) {
                    users.dni = int.parse(value);
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
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  inputFormatters: [
                    //Expresion Regular
                    FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                  ],
                  decoration: decorationinputtext('Ingresa DNI', 'DNI'),
                ),
                spacingheight10,
                TextFormField(
                  initialValue: users.password,
                  onChanged: (value) {
                    users.password = value;
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
                  keyboardType: TextInputType.text,
                  decoration:
                      _decorationinputtext2('ingrese contraseña', 'Contraseña'),
                  obscureText: isVisible,
                ),
                spacingheight10,
                DropdownButtonFormField(
                    hint: Text(users.cargo),
                    decoration: decorationinputtext(
                        'Ingresa puesto de usuario', 'Puesto de trabajo'),
                    items: cargoPuesto
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      users.cargo = value!;
                      isChecked = true;
                      setState(() {});
                    }),
                spacingheight10,
                TextFormField(
                    initialValue: users.direccion,
                    onChanged: (value) {
                      users.direccion = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: decorationinputtext(
                        'Ingrese la dirección', 'Dirección')),
                spacingheight10,
                TextFormField(
                    initialValue: users.id == null
                        ? users.telefono.toString().substring(
                              1,
                            )
                        : users.telefono.toString(),
                    onChanged: (value) {
                      users.telefono = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationinputtext(
                        'Ingrese nº telefonico', 'Nº Telefono')),
                spacingheight10,
                TextFormField(
                    initialValue: users.id == null
                        ? users.calification.toString().substring(
                              1,
                            )
                        : users.calification.toString(),
                    onChanged: (value) {
                      users.calification = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationinputtext(
                        'Ingrese calificacion', 'Horas extras')),
                spacingheight10,
                TextFormField(
                    initialValue: users.correo,
                    onChanged: (value) {
                      users.correo = value;
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'este campo es obligatorio';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return ("Ingrese un correo valido");
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: decorationinputtext(
                        'Ingrese correo', 'Correo electronico')),
                spacingheight10,
                SwitchListTile.adaptive(
                  value: users.estatus,
                  title: users.estatus == true
                      ? const Text(
                          'Disponible',
                          style: TextStyle(color: Colors.black),
                        )
                      : const Text(
                          'No Disponible',
                          style: TextStyle(color: Colors.red),
                        ),
                  activeColor: Colors.black,
                  onChanged: uForm.updateAvailability,
                ),
                spacingheight30
              ],
            )),
      ),
    );
  }

  InputDecoration _decorationinputtext2(String hintText, String labeltext) {
    return InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        errorBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        disabledBorder: outlineInputBorder(),
        focusedErrorBorder: outlineInputBorder(),
        fillColor: Colors.white,
         filled: true,
        hintText: hintText,
        labelText: labeltext,
        suffixIcon: IconButton(
            onPressed: () {
              isVisible = !isVisible;
              setState(() {});
            },
            icon: Icon(
              isVisible != true ? Icons.visibility : Icons.visibility_off,
              size: 16,
              color: kfontPrimaryColor.withOpacity(.5),
            )));
  }
}
