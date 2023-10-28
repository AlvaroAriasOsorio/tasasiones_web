
import 'package:crud_sheety/UI/general/colors.dart';
import 'package:crud_sheety/UI/general/spaicing.dart';
import 'package:crud_sheety/UI/widget/card_blur_wdiget.dart';
import 'package:crud_sheety/UI/widget/text_custom.dart';
import 'package:crud_sheety/Xprueba%20borrar/usuario_gestion_pages_form.dart';
import 'package:crud_sheety/models/user_model.dart';
import 'package:crud_sheety/service/user_provider.dart';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class UsuariogestionPage extends StatefulWidget {
  const UsuariogestionPage({super.key});

  @override
  State<UsuariogestionPage> createState() => _UsuariogestionPageState();
}

class _UsuariogestionPageState extends State<UsuariogestionPage> {
  User currentUser = User(
    nombreCompleto: 'Nombre',
    apellido: 'apellido',
    password: '',
    estatus: true,
    calification: 0,
    dni: 10000000,
    direccion: '',
    telefono: 0,
    role: '',
    image:
        'https://res.cloudinary.com/dw2vwrqem/image/upload/v1675870053/andean%20lodges/logo_1_h7bqim.png',
    cargo: '',
    correo: 'correo electrónico',
    genero: 'genero',
  );

  double position = 0.0;
  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<RecursosProvider>(context);
    final List<User> usuarios = userList.recursoList;

    return Scaffold(
      
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          leading: const BackButton(
            color: Colors.black,
          ),
          title: const H1(
              fontSize: 18,
              text: 'Gestionar usuarios',
              textColor: Colors.black),
          actions: [
            InkWell(
              onTap: () async {
                userList.selectedUser = User(
                  nombreCompleto: '',
                  apellido: '',
                  dni: 0,
                  password: '',
                  direccion: 'Av. Ejemplo',
                  telefono: 0,
                  image:
                      'https://res.cloudinary.com/dw2vwrqem/image/upload/v1675870053/andean%20lodges/logo_1_h7bqim.png', //7pickerFile!.path,
                  role: 'cliente',
                  cargo: 'cliente',
                  correo: 'example@gmail.com',
                  genero: 'masculino',
                  estatus: true,
                  calification: 1,
                );

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsuarioModule()));
                setState(() {});
              },
              child: BlurWidget(
                colorblur: kfont3erColor,
                height: null,
                child: Row(
                  children: [
                    spacingwidth10,
                    const Icon(
                      Icons.add_reaction_sharp,
                      size: 20,
                      color: Colors.white,
                    ),
                    spacingwidth10,
                    const H1(
                        fontSize: 14,
                        text: 'Nuevo',
                        textColor: Colors.white),
                    spacingwidth10
                  ],
                ),
              ),
            )
          ]),

      body:  Padding(
       padding: const EdgeInsets.only(top: 10.0),
       child: SingleChildScrollView(
         child: Container(
           constraints: const BoxConstraints(maxWidth: 600),
           child: Column(
             children: [
               ...List.generate(usuarios.length, (index) {
                 final userIo = usuarios[index]; //IMPORTANTE
                 return GestureDetector(
                   onTap: () => setState(() {
                     if (position == 0) {
                       position = 1;
                       currentUser = userIo;
                     } else {
                       position = 0;
                       currentUser = userIo;
                     }
                   }),
                   child: Column(
                     children: [
                       ListTile(
                         leading: CircleAvatar(
                           backgroundColor: Colors.white,
                           child: InkWell(
                               onTap: () {
                                 userList.selectedUser = userList
                                     .recursoList[index]
                                     .copy();
         
                                 Navigator.push(
                                     context,
                                     MaterialPageRoute(
                                         builder: (context) =>
                                             const UsuarioModule()));
                               },
                               child: const Icon(Icons.edit, color: Colors.black,)),
                         ),
                         title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${usuarios[index].nombreCompleto}  ${usuarios[index].apellido}',
                            ),
                            CircleAvatar(
                              child: InkWell(
                                onTap: () {
                                  userList.deleteUser(usuarios[index].id!);
                                },
                                child:Icon(Icons.delete),
                              ),
                            )
                          ],
                        ),
                         subtitle: H1(
                           fontSize: 15,
                           text: usuarios[index].estatus
                               ? 'activo'
                               : 'inactiva'.toUpperCase(),
                           textColor: usuarios[index].estatus
                               ? Colors.blue
                               : Colors.pinkAccent,
                         ),
                         trailing: Switch.adaptive(
                           inactiveTrackColor:
                               Colors.black.withOpacity(.3),
                           value: usuarios[index].estatus,
                           onChanged: (value) {
                             usuarios[index].estatus = value;
                             setState(() {});
                             userList.saveOrCreateProduct(
                                 usuarios[index]);
                           },
                         ),
                       ),
                       divider
                     ],
                   ),
                 );
               }),
             ],
           ),
         ),
       ),
                  )
        
      // extendBody: true,
    );
  }
}
