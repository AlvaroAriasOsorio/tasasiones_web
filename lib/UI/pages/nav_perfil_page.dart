// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:crud_sheety/UI/general/general.dart';
import 'package:crud_sheety/UI/pages/login_page.dart';
import 'package:crud_sheety/UI/pagesModules/pagina_datatable.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:crud_sheety/Xprueba%20borrar/usuario_gestion_page.dart';
import 'package:crud_sheety/Xprueba%20borrar/usuario_gestion_pages_form.dart';
import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/service/service.dart';
import 'package:crud_sheety/UI/widget/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import 'package:vector_math/vector_math_64.dart' as vector;

class NavPerfilPage extends StatefulWidget {
  NavPerfilPage({super.key, required this.listusers, required this.index});
  RecursosProvider listusers;
  int index;

  @override
  State<NavPerfilPage> createState() => _NavPerfilPageState();
}

class _NavPerfilPageState extends State<NavPerfilPage> {
 

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: SliverAppBAr(index: widget.index),
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  spacingheight100,
                  Container(
                    color:  const Color.fromARGB(255, 71, 13, 13),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UsuariogestionPage(),));
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.people,color: Colors.white,),
                              H1(text:'Gestiòn Usuarios',textColor: Colors.white,fontSize: 13,)
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyDataTable(listusers: widget.listusers, index: widget.index,),));
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.safety_divider_outlined,color: Colors.white,),
                             H1(text:'Tasasiones',textColor: Colors.white,fontSize: 13,)
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                          Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                        },
                          child: const Column(
                            children: [
                              Icon(Icons.offline_bolt_rounded,color: Colors.white,),
                              H1(text:'Cerrar sesiòn',textColor: Colors.white,fontSize: 13,)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  spacingheight100,
                  Container(
                    padding: const EdgeInsets.all(30),
                    height: 800,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Bienvenido a nuestro innovador Software de Tasaciones: Diseñado con precisión y potenciado por tecnología de vanguardia, nuestro software para el área de tasaciones es la herramienta esencial para profesionales y expertos en bienes raíces. Simplificando el proceso de tasación, nuestro software integra datos precisos y análisis profundos para ofrecerte evaluaciones detalladas y confiables. Desde la evaluación de propiedades residenciales hasta complejas valoraciones comerciales, nuestra plataforma intuitiva te guiará a través de cada paso, permitiéndote realizar tasaciones precisas en tiempo récord. ¡Descubre la eficiencia y precisión que tu trabajo merece con nuestro software líder en la industria!",
                        style: TextStyle(fontSize: 15),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  )
                  ,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




const maxHeight = 350.0;
const minHeight = 120.0;

const maxImageSize = 150.0;
const minImageSize = 50.0;

const maxTitleSize = 25.0;
const maxSubTitleSize = 18.0;

const minTitleSize = 20.0;
const minSubTitleSize = 1.0;

class SliverAppBAr extends SliverPersistentHeaderDelegate {
  SliverAppBAr({required this.index});
  int index;
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {

    final size = MediaQuery.of(context).size;
    final percent = shrinkOffset / maxHeight;
    final currentImagesize =
        (maxHeight * (1 - percent)).clamp(minImageSize, maxImageSize);
    final userList = Provider.of<RecursosProvider>(context);
    final List<User> usua = userList.recursoList;

    return Container(
      color: const Color.fromARGB(255, 18, 18, 18),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            bottom: 0,
            child: TextButton(
              onPressed: () {
                userList.selectedUser = userList.recursoList[index].copy();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UsuarioModule()));
              },
              child: const Row(
                children: [
                  H1(
                      fontSize: 18,
                      text: 'Editar',
                      textColor: Colors.white),
                  Icon(Icons.edit,color: Colors.white,),
                ],
              ),
            ),
          ),
          Positioned(
              top: currentImagesize,
              right: 10,
              child: SizedBox(
                width: size.width * .5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textUi(percent, 'Dirección: ${usua[index].direccion}'),
                    _textUi(percent, 'Puesto   : ${usua[index].cargo}'),
                    _textUi(percent, 'Rol      : ${usua[index].role}'),
                    _textUi(percent, 'DNI      : ${usua[index].dni}'),
                    _textUi(percent, 'Genero   : ${usua[index].genero}'),
                    _textUi(percent, 'Nombre  : ${usua[index].nombreCompleto}'),
                    _textUi(percent, 'Apellido  : ${usua[index].apellido}'),
                    _textUi(percent, 'Contraseña : ${usua[index].password}'),
                    // spacingheight10,
                  ],
                ),
              )),
          Positioned(
            top: 60,
            left: ((size.width * .3) + (60 * percent)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                H1(
                    fontSize: (maxTitleSize * (1 - percent))
                        .clamp(minTitleSize, maxTitleSize),
                    text: 'Bienvenido ${usua[index].nombreCompleto}',
                    textColor: Colors.white),
                H1(
                    fontSize: ((maxTitleSize - 7) * (1 - percent))
                        .clamp(minSubTitleSize, maxSubTitleSize),
                    text: ' ${usua[index].correo}',
                    textColor: Colors.white.withOpacity(.5)),
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              left: (10 * (1 - percent)).clamp(33, 150),
              height: currentImagesize,
              child: Transform.rotate(
                  angle: vector.radians(360 * percent),
                  child: TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 500),
                    tween: Tween(begin: 1, end: 0),
                    curve: Curves.elasticOut,
                    builder: (context, value, _) {
                      
                      return Transform.translate(
                        offset: Offset(value * 100, 0),

                        child: Container(
                          height: currentImagesize,
                          width: currentImagesize,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage('assets/user.jpeg'))),
                        ),
                      );
                    },
                  ))),
        ],
      ),
    );
  }

  H1 _textUi(double percent, String text) {
    return H1(
        fontSize: ((maxTitleSize - 11) * (1 - percent))
            .clamp(minSubTitleSize, maxSubTitleSize),
        text: text,
        textColor: Colors.blue);
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
