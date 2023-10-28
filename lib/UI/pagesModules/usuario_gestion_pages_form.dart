import 'dart:io';

import 'package:crud_sheety/UI/general/general.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:crud_sheety/models/tasasiones_model.dart';
import 'package:crud_sheety/service/service.dart';
import 'package:crud_sheety/service/tasasiones_provider.dart';
import 'package:crud_sheety/UI/widget/scroll_web.dart';
import 'package:crud_sheety/UI/widget/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasasionesModule extends StatelessWidget {
  const TasasionesModule({super.key});

  @override
  Widget build(BuildContext context) {
  
    final userProvider = Provider.of<TasasionesProvider>(context);
    return ChangeNotifierProvider(
      create: (_) => TasasioneFormProvider(userProvider.selectedUser),
      child: _ProductScreenBody(userProvider: userProvider),
    );
  }
}

class _ProductScreenBody extends StatefulWidget {
  const _ProductScreenBody({
    required this.userProvider,
  });

  final TasasionesProvider userProvider;

  @override
  State<_ProductScreenBody> createState() => _ProductScreenBodyState();
}

class _ProductScreenBodyState extends State<_ProductScreenBody> {
  bool expandedimage = false;
  @override
  Widget build(BuildContext context) {
    final uForm = Provider.of<TasasioneFormProvider>(context);

    return Scaffold(
      extendBody: true,
      backgroundColor:  const Color.fromARGB(255, 74, 77, 86),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 74, 77, 86),
        title:const H1(text: 'Datos de Cliente',textColor: Colors.white,),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ScrollWeb(
            child: SingleChildScrollView(
              child: Container(
                constraints: const BoxConstraints(maxWidth: 500),
                child: const TasasionesFOrm()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: widget.userProvider.isaving
                          ? null
                          : () async {
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
                              color: Colors.white,
                            ),
      ),
    );
  }
}

class TasasionesFOrm extends StatefulWidget {
  const TasasionesFOrm({super.key});
  @override
  State<TasasionesFOrm> createState() => _TasasionesFOrmState();
}

class _TasasionesFOrmState extends State<TasasionesFOrm> {
  bool isChecked = false;
  bool isVisible = true;
 final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final uForm = Provider.of<TasasioneFormProvider>(context);
    final tasac = uForm.userform;

    return BlurWidget(
      colorblur: Colors.white.withOpacity(.8),
      height: null,
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 60, right: 20, bottom: 0),
        child: Form(
            key: uForm.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                 TextFormField(
                  initialValue: tasac.idBanca,
                  onChanged: (value) => tasac.idBanca = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('ID Banco', 'Id banco'),
                ),
                spacingheight10,
                TextFormField(
                  initialValue: tasac.cliente,
                  onChanged: (value) => tasac.cliente = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  decoration:
                      decorationinputtext('Nombre del Cliente', 'Cliente'),
                  keyboardType: TextInputType.text,
                ),
                spacingheight10,
                TextFormField(
                  initialValue: tasac.solicitante,
                  onChanged: (value) => tasac.solicitante = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Nombre Solicitante', 'Solicitante'),
                ),
                spacingheight10,
               
                TextFormField(
                    initialValue: tasac.propietario,
                    onChanged: (value) => tasac.propietario = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: decorationinputtext(
                        'Nombre Propietario', 'Propietario')),
                spacingheight10,
                TextFormField(
                    initialValue: tasac.ubicacion,
                    onChanged: (value) => tasac.ubicacion = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    decoration: decorationinputtext(
                        'Ingrese la Ubicación', 'Ubicación')),
                spacingheight10,
                 TextFormField(
                    initialValue: tasac.id == null
                        ? tasac.valorDelM2DeTerrenoDpto.toString().substring(
                              1,
                            )
                        : tasac.valorDelM2DeTerrenoDpto.toString(),
                    onChanged: (value) {
                      tasac.valorDelM2DeTerrenoDpto = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationinputtext(
                        'Valor m2 de Terreno/Dpto', 'Valor en m2')),
                        spacingheight10,
                TextFormField(
                    initialValue: tasac.id == null
                        ? tasac.valorComercial.toString().substring(
                              1,
                            )
                        : tasac.valorComercial.toString(),
                    onChanged: (value) {
                      tasac.valorComercial = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationinputtext(
                        'Valor Comercial', 'Valor comercial')),
                 spacingheight10,
                
                TextFormField(
                    initialValue: tasac.id == null
                        ? tasac.valorRealizacion .toString().substring(
                              1,
                            )
                        : tasac.valorRealizacion.toString(),
                    onChanged: (value) {
                      tasac.valorRealizacion = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationinputtext(
                        'Valor Realizacion', 'Valor Realizacion')),
                spacingheight10,
                TextFormField(
                  initialValue: tasac.ubicacionMaps,
                  onChanged: (value) {
                    tasac.ubicacionMaps = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Url Gps Google Maps', 'Url maps'),
                ),
                spacingheight10,
                TextFormField(
                  initialValue: tasac.linkInformepdf,
                  onChanged: (value) {
                    tasac.linkInformepdf = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Url Documento Pdf', 'Url Pdf'),
                ),
                Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      readOnly: true, // Evita que el usuario pueda editar el valor manualmente
                      onTap: () {
                        _selectDate(context, tasac);
                      },
                      decoration: const InputDecoration(
                        labelText: 'Fecha de Visita',
                        hintText: 'Seleccionar fecha',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () {
                      _selectDate(context, tasac);
                    },
                  ),
                ],
              ),
                spacingheight10,
                SwitchListTile.adaptive(
                  value: tasac.estatus,
                  title: tasac.estatus == true
                      ? const Text(
                          'Culminado',
                          style: TextStyle(color: Colors.black),
                        )
                      : const Text(
                          'Pendiente',
                          style: TextStyle(color: Colors.red),
                        ),
                  activeColor: Colors.black,
                  onChanged: uForm.updateAvailability,
                ),
                spacingheight30,
                 Text(
                  'Solicitudes del Banco con Datos de Clientes e Inmuebles'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Estilo del texto en negrita
                      color: Colors.grey, // Color del texto del título
                    ),
                  ),
                  spacingheight30,
                 TextFormField(
                    initialValue: tasac.id == null
                        ? tasac.bt.toString().substring(
                              1,
                            )
                        : tasac.bt.toString(),
                    onChanged: (value) {
                      tasac.bt = int.parse(value);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'campo obligatorio';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: decorationinputtext(
                        'BT', 'Codìgo BT')),
                spacingheight10,
                TextFormField(
                  initialValue: tasac.tipoBanca,
                  onChanged: (value) {
                    tasac.tipoBanca = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Tipo Banca', 'Ingrese Tipo banca'),
                ),
                spacingheight10,
                 TextFormField(
                  initialValue: tasac.nDocumento,
                  onChanged: (value) {
                    tasac.nDocumento = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Nª Docuemnto', 'Ingrese nro. documento'),
                ),
                spacingheight10,
                 TextFormField(
                  initialValue: tasac.mes,
                  onChanged: (value) {
                    tasac.mes = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Mes de Solicitud', 'Ingrese mes de solicitud'),
                ),
                spacingheight10,
                 TextFormField(
                  initialValue: tasac.funcionarioBanco,
                  onChanged: (value) {
                    tasac.funcionarioBanco = value;
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obligatorio';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration:
                      decorationinputtext('Funcionario de Banca', 'Ingrese Funcionario de banca'),
                ),
                spacingheight100,
              ],
            )),
      ),
    );
  }
    Future<void> _selectDate(BuildContext context, Tasasione tasac) async {
      DateTime? selectedDate = DateTime.now();

      if (tasac.programarFechaVisita != null) {
        selectedDate = DateTime.tryParse(tasac.programarFechaVisita);
        if (selectedDate == null) {
          selectedDate = DateTime.now();
        }
      }

      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        setState(() {
          tasac.programarFechaVisita = picked.toLocal().toString(); // Convierte DateTime a String
          _dateController.text = "${picked.year}-${picked.month}-${picked.day}";
        });
      }
    }


  InputDecoration decorationinputtext2(String hintText, String labeltext) {
    return InputDecoration(
        enabledBorder: outlineInputBorder(),
        focusedBorder: outlineInputBorder(),
        errorBorder: outlineInputBorder(),
        border: outlineInputBorder(),
        disabledBorder: outlineInputBorder(),
        focusedErrorBorder: outlineInputBorder(),
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
