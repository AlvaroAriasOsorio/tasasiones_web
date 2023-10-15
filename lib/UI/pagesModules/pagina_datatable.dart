// ignore_for_file: library_private_types_in_public_api, deprecated_member_use

import 'package:crud_sheety/UI/general/logo_assets.dart';
import 'package:crud_sheety/UI/pagesModules/usuario_gestion_pages_form.dart';
import 'package:crud_sheety/models/tasasiones_model.dart';
import 'package:crud_sheety/service/tasasiones_provider.dart';
import 'package:crud_sheety/utils/scroll_web.dart';
import 'package:crud_sheety/utils/text_custom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDataTable extends StatelessWidget {
  const MyDataTable({super.key});

 @override
  Widget build(BuildContext context) {
    final userList = Provider.of<TasasionesProvider>(context);
    final List<Tasasione> tasasiones = userList.tasasiones;

    return MyDataTableList(
      tasasiones: tasasiones,
    );
  }
}

class MyDataTableList extends StatefulWidget {
  const MyDataTableList({super.key, required this.tasasiones});
  final List<Tasasione> tasasiones;
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
 

  // 
  @override
  Widget build(BuildContext context) {
    final userList = Provider.of<TasasionesProvider>(context);
    
    final size = MediaQuery.of(context).size;
    return Scaffold(
       backgroundColor:  const Color.fromARGB(255, 74, 77, 86),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 77, 86),
        centerTitle: false,
        title:  H1(
          text: 'Área de Operaciones de Tasaciones'.toUpperCase(),textColor: Colors.white, ),),
       endDrawer: const Drawer(),
      body: ScrollWeb(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Row(
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
                          userList: userList),
                    )),
                Expanded(
                    flex: 1,
                    child:Container(
                      height: size.height,
                        color: Colors.white.withOpacity(.5),
                      child: UserDataCard()), )
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
              programarFechaVisita: DateTime.now().toString());

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UsuarioModule()));
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
  }) : _searchController = searchController;

  final TextEditingController _searchController;
  final List<Tasasione> filteredUsuarios;
  final MyDataTableList widget;
  final TasasionesProvider userList;

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
              decoration: const InputDecoration(
                hintText: 'Buscar...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            // sortColumnIndex: 1, // Índice de la columna de ordenamiento
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
            rowsPerPage: 10, // Número de filas por página
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
                userCopy: userCopy), // Utiliza la lista filtrada en lugar de la original
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
  MyData(this.usuarios, {required this.context, required this.userList,required this.userCopy});

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
              row.estatus = value;
              // setState(() {});
              userList.saveOrCreateProduct(usuarios[index]);
            },
          ),
        ),
        DataCell(CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black12,
          child: InkWell(
              onTap: () {
                userList.selectedUser = userList.tasasiones[index].copy();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsuarioModule()));
              },
              child: SvgPicture.asset(
                AssetsDataSVG.editar,
                width: 20,
                height: 20,
              )),
        )),
        DataCell(
        CircleAvatar(
          radius: 15,
          backgroundColor: Colors.black12,
          child: InkWell(
            onTap: () {
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
              propietario: 'propietario', 
              ubicacion: 'ubicacion', 
              valorDelM2DeTerrenoDpto: 0, 
              valorComercial: 0, 
              valorRealizacion: 0, 
              ubicacionMaps: 'https://www.google.com/maps/d/u/0/viewer?hl=es&ll=-13.531423660713978%2C-71.96516860146622&z=18&mid=10OuYasweah8hHKTOP6XAGzKeoRlMEzQ', 
              linkInformepdf: 'https://archivo.ucr.ac.cr/docum/tesis2.pdf', 
              estatus: true, 
              programarFechaVisita: DateTime.now().toString());

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
   // Función para abrir el enlace
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir el enlace $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<MyProvider>(context).listaCompra;
    return Column(
      children: [
        Card(
          elevation: 4,
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    userData.cliente,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(userData.solicitante),
                  leading: const FlutterLogo(size: 56), // Logo de Flutter
                ),
                const Divider(),
                ListTile(
                  title: Text(userData.idBanca),
                  leading: const H1(text:'ID Banco:',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
                ListTile(
                  title: Text(userData.propietario),
                   leading: const H1(text:'Propietario:',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
                ListTile(
                  title: Text(userData.ubicacion),
                  leading: const H1(text:'Ubicación:',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
                ListTile(
                  title: Text('${userData.valorDelM2DeTerrenoDpto}'),
                  leading: const H1(text:'Valor M2 Terreno/Dpto:',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
                ListTile(
                  title: Text('${userData.valorComercial}'),
                  leading: const H1(text:'Valor Comercial:',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
                ListTile(
                  title: Text('${userData.valorRealizacion}'),
                  leading: const H1(text:'Valor Realización:',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                    // Botón para abrir el enlace
                ElevatedButton(
                  onPressed: () => _launchURL(userData.ubicacionMaps),
                  child: const Text('Abrir Ubicación Maps'),
                ),
                // Botón para abrir el enlace
                ElevatedButton(
                  onPressed: () => _launchURL(userData.linkInformepdf),
                  child: const Text('Abrir Informe PDF'),
                ),
               ],
               ),
                ListTile(
                  title: Text(userData.programarFechaVisita),
                  leading: const H1(text:'Fecha de Visita: ',textColor: Color.fromARGB(255, 30, 1, 1),),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
