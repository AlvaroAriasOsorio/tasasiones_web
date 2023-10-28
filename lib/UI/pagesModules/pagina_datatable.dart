
// ignore_for_file: must_be_immutable, deprecated_member_use

import 'package:crud_sheety/UI/general/inputdecoration_form.dart';
import 'package:crud_sheety/UI/pages/login_page.dart';
import 'package:crud_sheety/UI/pagesModules/usuario_gestion_pages_form.dart';
import 'package:crud_sheety/models/tasasiones_model.dart';
import 'package:crud_sheety/service/tasasiones_provider.dart';
import 'package:crud_sheety/service/user_provider.dart';
import 'package:crud_sheety/UI/widget/scroll_web.dart';
import 'package:crud_sheety/UI/widget/text_custom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDataTable extends StatelessWidget {
  const MyDataTable({super.key, required this.listusers, required this.index});
  final  RecursosProvider listusers;
  final int index;
 
 @override
  Widget build(BuildContext context) {
    final userList = Provider.of<TasasionesProvider>(context);
    final List<Tasasione> tasasiones = userList.tasasiones;

    return MyDataTableList(
      tasasiones: tasasiones, listusers: listusers, index: index,
    );
  }
}

class MyDataTableList extends StatefulWidget {
  const MyDataTableList({super.key, required this.tasasiones, required this.listusers, required this.index});
  final List<Tasasione> tasasiones;
  final  RecursosProvider listusers;
  final int index;
  @override
  _MyDataTableState createState() => _MyDataTableState();
}

class _MyDataTableState extends State<MyDataTableList> {
  final TextEditingController _searchController =  TextEditingController(); // Controlador del campo de búsqueda

  List<Tasasione> filteredUsuarios = []; // Lista de usuarios filtrados
 
  @override
  void initState() {
    super.initState();
    filteredUsuarios = widget.tasasiones; // Inicializamos la lista con todos los elementos del widget padre (todos los usuarios).
    _searchController.addListener(filterUsuarios);
  }
  void filterUsuarios() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredUsuarios = widget.tasasiones.where((user) {
        final nombreCompleto = user.cliente.toLowerCase() ;
        return nombreCompleto.contains(query);
      }).toList();
    });
  }
  // ALERTA filtracion de datos segun su fecha y estado : fecha está dentro del rango de 5 días a partir de la fecha actual:
   List<Tasasione> getExpirationAlertProducts() {
    final currentDate = DateTime.now();
    return widget.tasasiones.where((product) {
      if (!product.estatus) {
        final expirationDate = DateTime.parse(product.programarFechaVisita);
      final daysUntilExpiration = expirationDate.difference(currentDate).inDays;
      return daysUntilExpiration <= 7;
      } else {
      return false; // Retorna false para los elementos con estatus true
      }
    }).toList();
  }
  
  // ASIGNAMOS UN KEY para globalizar el Scaffold: esto sirve para llamar al boton de drawer
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 
     String formatDate(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    
    final String month = monthNames[parsedDate.month - 1]; // Obtiene el nombre del mes
    final String day = parsedDate.day.toString(); // Obtiene el día como número
    final String year = parsedDate.year.toString(); // Obtiene el año como número
    // final String hour = parsedDate.hour.toString(); // Obtiene la hora como número
    // final String minute = parsedDate.minute.toString().padLeft(2, '0'); // Obtiene los minutos como número y asegura que tengan dos dígitos
    
    return '$month $day, $year';
  }

  // Lista de nombres de meses
  List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ];
  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<TasasionesProvider>(context);
    String usuario= widget.listusers.recursoList[widget.index].nombreCompleto; 
    String role = widget.listusers.recursoList[widget.index].role;
    final size = MediaQuery.of(context).size;

    final expirationAlertProducts = getExpirationAlertProducts();
    return Scaffold(
       key: _scaffoldKey, // Asigna el GlobalKey al Scaffold
       backgroundColor: Colors.white,
       appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black), 
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 90,
        centerTitle: false,
        title:  Column(
          children: [
            H1(
              text: 'Área de Operaciones de Tasaciones'.toUpperCase(),textColor: Colors.black, ),
                    Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: H1(
                    text: '!Bienvanido $usuario ¡' 
                    '\nUsted ha iniciado sesion como ${role.toUpperCase()} ',textColor: Colors.indigo, fontSize: 12,),
               ),
          ],
        ),
        actions: [
        
           InkWell(
            onTap: () {
              // Esta función se ejecutará cuando se presione el icono del AppBar
                    _scaffoldKey.currentState?.openEndDrawer(); // Abre el endDrawer al presionar el icono del AppBar
            },
             child: Stack(
               children: [
                 const Icon(Icons.add_alert_rounded,size: 45,color: Color.fromARGB(255, 57, 55, 55),),
                expirationAlertProducts.isEmpty ?   const SizedBox() : Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 236, 23, 23),
                      shape: BoxShape.circle
                    ),
                    child: H1(text:expirationAlertProducts.length.toString(),fontSize: 13,textColor: Colors.white,))),

                 
               ],
             ),
           ),
            Card(
                  margin: const EdgeInsets.only(top:2, right: 10, left: 10, bottom: 45),
                   color: const Color.fromARGB(255, 236, 23, 23),
                  child: TextButton(onPressed: (){
                    Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                  },  child: const H1(text:'Cerrar sesiòn',textColor: Colors.white,fontSize: 13,)),
                ),
        ],
        ),
       endDrawer:  Drawer(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.amber, // Puedes personalizar el color de fondo aquí
                child: const ListTile(
                  title:Text(
                    'Alertas de Fechas Próximas de Visitas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ) ,
                  trailing:Icon(
                    Icons.notifications, // Icono de campana
                    color: Colors.white,
                    size: 32, // Tamaño del icono
                  ),
                ),
              ),
              Expanded(
              child: ScrollWeb(
                child: ListView.separated(
                  itemCount: expirationAlertProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = expirationAlertProducts[index];
                    return ListTile(
                      leading: CircleAvatar(child: Text('${index +1}'),),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          H1(text: product.cliente.toUpperCase(), fontSize: 14,),
                          H1(text: product.solicitante, fontSize: 14,),
                          const Divider(thickness: 1,color: Colors.blue,)
                        ],
                      ),
                      subtitle: Text('Fecha de Visita:\n ${formatDate(product.programarFechaVisita)}'),
                    );
                  }, separatorBuilder: (BuildContext context, int index) => const Divider(thickness: 1,color: Colors.black12,),
                ),
              ),
            ),
              // const Spacer(),
              Card(
                margin: const EdgeInsets.all(0),
                color: Colors.red,
                child: TextButton.icon(onPressed: (){
                  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                }, icon: const Icon(Icons.clear_outlined,color: Colors.white,), label: const H1(text:'Cerrar sesiòn',textColor: Colors.white,fontSize: 13,)),
              ),
            ],
          ),
        ),
       ),
      body: ScrollWeb(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Stack(
              children: [
                
                Row(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Container(
                           height: size.height,
                            color: Colors.white.withOpacity(.5),
                          child: TablePaginada(
                              searchController: _searchController,
                              filteredUsuarios: filteredUsuarios,
                              widget: widget,
                              userList: userList, role: role,),
                        )),
                    Container(
                      constraints: const BoxConstraints(minWidth: 350, maxWidth: 450),
                      height: size.height,
                        color: Colors.white.withOpacity(.5),
                      child:  UserDataCard()), 
                    
                  ],
                ),
               
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
          onPressed: () async {
             userList.selectedUser = Tasasione(
              // id: 0, 
              idBanca: 'idBanca', 
              cliente: 'cliente', 
              solicitante: 'solicitante', 
              propietario: 'propietario', 
              ubicacion: 'ubicacion', 
              valorDelM2DeTerrenoDpto: 0, 
              valorComercial: 0, 
              valorRealizacion: 0, 
              ubicacionMaps: 'https://www.google.com/maps/d/u/0/viewer?hl=es&ll=-13.531423660713978%2C-71.96516860146622&z=18&mid=10OuYasweah8hHKTOP6XAGzKeoRlMEzQ', 
              linkInformepdf: 'https://archivo.ucr.ac.cr/docum/tesis2.pdf', 
              estatus: true, 
              programarFechaVisita: DateTime.now().toString(), 
              mes: '', 
              bt: 0, 
              tipoBanca: '', 
              nDocumento: '', 
              funcionarioBanco: '');

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const TasasionesModule()));
            setState(() {});
          },
          child: const Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          )),
      // extendBody: true,
    );
  }
}

class TablePaginada extends StatelessWidget {
  const TablePaginada({
    super.key,
    required TextEditingController searchController,
    required this.filteredUsuarios,
    required this.widget,
    required this.userList,
    required this.role
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final List<Tasasione> filteredUsuarios;
  final MyDataTableList widget;
  final TasasionesProvider userList;
  final String role;

  @override
  Widget build(BuildContext context) {
    final userCopy = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PaginatedDataTable(
            header: TextField(
              controller: _searchController,
              decoration:decorationinputtext('Buscar..', 'Buscar un registro')),
            dataRowHeight: 35, // Altura de las filas de datos
            headingRowHeight: 40, // Altura de la fila de encabezado
            horizontalMargin: 10, // Margen horizontal
            columnSpacing: 20, // Espacio entre columnas
            showCheckboxColumn:
                true, // Mostrar columna de casilla de verificación
            showFirstLastButtons:
                true, // Mostrar botones de primera/última página
            initialFirstRowIndex:
                0, // Índice de la primera fila visible inicialmente
            dragStartBehavior:
                DragStartBehavior.start, // Comportamiento del arrastre
            arrowHeadColor: Colors.indigo, // Color de la cabeza de la flecha
            checkboxHorizontalMargin:
                10, // Margen horizontal de la casilla de verificación
            sortAscending: false, // Orden ascendente o descendente
            // onSelectAll:
            //     (value) {}, // Función cuando se selecciona/deselecciona todo
            primary:
                true, // Marcar como primario si es el Widget superior en la jerarquía
            rowsPerPage: 20, // Número de filas por página
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Cliente')),
              DataColumn(label: Text('Solicitante')),
              DataColumn(label: Text('Estado')),
              DataColumn(label: Text('Check')),
              DataColumn(label: Text('Editar')),
              DataColumn(label: Text('Eliminar')),
              DataColumn(label: Text('Detalles')),
            ],
            source: MyData(
                filteredUsuarios.isNotEmpty ? filteredUsuarios : widget.tasasiones,
                userList: userList,
                context: context,
                userCopy: userCopy, role: role), // Utiliza la lista filtrada en lugar de la original
          ),
        ],
      ),
    );
  }
}

class MyData extends DataTableSource {
  final List<Tasasione> usuarios;
  BuildContext context;
  TasasionesProvider userList;
  MyProvider userCopy;
  String role;
  MyData(this.usuarios, {required this.context, required this.userList,required this.userCopy, required this.role});

  @override
  DataRow? getRow(int index) {
    if (index >= usuarios.length) {
      return null;
    }
    final row = usuarios[index];
    return DataRow(
      selected: usuarios[index].estatus,
      onSelectChanged: (value) {},
      cells: [
        DataCell(H2(text: usuarios[index].id.toString())),
        DataCell(H2(text:row.cliente)),
        DataCell(H2(text:row.solicitante)),
        DataCell(H2(
          text: row.estatus ? 'Culminado' : 'Pendiente',
          textColor: row.estatus ? Colors.blue : Colors.pinkAccent,
        )),
        DataCell(
          Switch.adaptive(
            inactiveTrackColor: Colors.black.withOpacity(.3),
            value: row.estatus,
            onChanged: (value) {
             if (role == "admin") {
                row.estatus = value;
              // setState(() {});
              userList.saveOrCreateProduct(usuarios[index]);
             } else {
               null;
             }
            },
          ),
        ),
        DataCell(CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black12,
          child: InkWell(
              onTap: () {
                if (role == "admin") {
                  userList.selectedUser = userList.tasasiones[index].copy();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TasasionesModule()));
                } else {
                  null;
                }
                
              },
              child: const Icon(Icons.edit, color: Color.fromARGB(255, 69, 7, 3),)),
        )),
        DataCell(
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black12,
          child: InkWell(
            onTap: () {
              if (role == "admin") {
                showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirmar eliminación"),
                    content: const Text("¿Está seguro de que desea eliminar este elemento?"),
                    actions: <Widget>[
                      TextButton(
                        child: const Text("Cancelar"),
                        onPressed: () {
                          Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                        },
                      ),
                      TextButton(
                        child: const Text("Eliminar"),
                        onPressed: () {
                          // Lógica para eliminar el elemento
                          userList.deleteUser(usuarios[index].id!);
                          Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                        },
                      ),
                    ],
                  );
                },
              );
              } else {
                null;
              }
              
            },
            child: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 69, 7, 3),
            ),
          ),
        ),
        ),

        DataCell(CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black12,
          child: InkWell(
            onTap: () {
            //  userCopy.listaCompra  =row;
            userCopy.agregarListaCompra(row);
            },
            child: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color.fromARGB(255, 69, 7, 3),
            ),
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => usuarios.length;

  @override
  int get selectedRowCount => 0;
}

class MyProvider extends ChangeNotifier {
  // Metodo para tomar el valor de ListaCompra que se quiere editar
  Tasasione listaCompra = Tasasione(
              // id: 0, 
              idBanca: 'idBanca', 
              cliente: 'cliente', 
              solicitante: 'solicitante', 
              propietario: '', 
              ubicacion: '', 
              valorDelM2DeTerrenoDpto: 0, 
              valorComercial: 0, 
              valorRealizacion: 0, 
              ubicacionMaps: 'https://www.google.com/maps/d/u/0/viewer?hl=es&ll=-13.531423660713978%2C-71.96516860146622&z=18&mid=10OuYasweah8hHKTOP6XAGzKeoRlMEzQ', 
              linkInformepdf: 'https://archivo.ucr.ac.cr/docum/tesis2.pdf', 
              estatus: true, 
              programarFechaVisita: DateTime.now().toString(),
              mes: '', 
              bt: 0, 
              tipoBanca: '', 
              nDocumento: '', 
              funcionarioBanco: '');

  void agregarListaCompra(Tasasione value) {
    listaCompra = value;
    // print(listaCompra.cliente);
    notifyListeners();
  }

  Tasasione get obtenerListaCompra {
    // print(listaCompra.cliente);
    return listaCompra;
  }
}

class UserDataCard extends StatelessWidget {
   UserDataCard({super.key});

   // Función para abrir el enlace
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
  }
    String formatDate(String dateString) {
    final DateTime parsedDate = DateTime.parse(dateString);
    
    final String month = monthNames[parsedDate.month - 1]; // Obtiene el nombre del mes
    final String day = parsedDate.day.toString(); // Obtiene el día como número
    final String year = parsedDate.year.toString(); // Obtiene el año como número
    // final String hour = parsedDate.hour.toString(); // Obtiene la hora como número
    // final String minute = parsedDate.minute.toString().padLeft(2, '0'); // Obtiene los minutos como número y asegura que tengan dos dígitos
    
    return '$month $day, $year';
  }

  // Lista de nombres de meses
  List<String> monthNames = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ];

 @override
  Widget build(BuildContext context) {
    final userData = Provider.of<MyProvider>(context).listaCompra;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData.cliente,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(userData.solicitante),
                  ],
                ),
              ),
              const Divider(thickness: 1),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Fecha de Visita: ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        formatDate(userData.programarFechaVisita),
                      ),
                    ],
                  ),
             const Divider(thickness: 1),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('ID Banco: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(userData.idBanca),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Propietario: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(userData.propietario),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Ubicación: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(
                          child: Text(
                            userData.ubicacion,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis, // Puedes usar TextOverflow.fade si prefieres que el texto se desvanezca en lugar de usar puntos suspensivos
                          ),
                        ),
                      ],
                    ),
                     const Divider(thickness: 3),
                    
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Valor M2 Terreno/Dpto: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${userData.valorDelM2DeTerrenoDpto}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Valor Comercial: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${userData.valorComercial}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Text('Valor Realización: ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('${userData.valorRealizacion}'),
                      ],
                    ),
                    const SizedBox(height: 16),
                      const Divider(thickness: 1),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlinedButton(
                        onPressed: () => _launchURL(userData.ubicacionMaps),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue, side: const BorderSide(color: Colors.blue, width: 2), // Grosor y color del borde
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Bordes redondeados
                        ),
                        child: const Text('Abrir Ubicación Maps'),
                      ),
                      OutlinedButton(
                        onPressed: () => _launchURL(userData.linkInformepdf),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue, side: const BorderSide(color: Colors.blue, width: 2), // Grosor y color del borde
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Bordes redondeados
                        ),
                        child: const Text('Abrir Informe PDF'),
                      ),
                    ],
                  ),
                    const SizedBox(height: 16),
                      const Divider(thickness: 1),
                   Text(
                  'Solicitudes del Banco con Datos de Clientes e Inmuebles'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold, // Estilo del texto en negrita
                      color: Colors.grey, // Color del texto del título
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Primer conjunto de datos
                      Row(
                        children: [
                          const Text('Mes: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userData.mes),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Segundo conjunto de datos
                      Row(
                        children: [
                          const Text('BT: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userData.bt.toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Tercer conjunto de datos
                      Row(
                        children: [
                          const Text('Tipo de Banca: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userData.tipoBanca),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Cuarto conjunto de datos
                      Row(
                        children: [
                          const Text('Número de Documento: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userData.nDocumento),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Quinto conjunto de datos
                      Row(
                        children: [
                          const Text('Funcionario del Banco: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(userData.funcionarioBanco),
                        ],
                      ),
                      
                    ],
                  )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}