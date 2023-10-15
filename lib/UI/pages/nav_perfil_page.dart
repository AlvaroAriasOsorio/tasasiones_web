// ignore_for_file: depend_on_referenced_packages, must_be_immutable

import 'package:crud_sheety/UI/general/general.dart';
import 'package:crud_sheety/UI/pages/login_page.dart';

import 'package:crud_sheety/UI/pagesModules/usuario_gestion_pages_form.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/service/service.dart';
import 'package:bubble_lens/bubble_lens.dart';
import 'package:crud_sheety/utils/text_custom.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
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
 
  bool isVisbleLegend = false;
  int tab = 0;
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
            child: BlurWidget(
              colorblur: const Color.fromARGB(255, 222, 221, 221),
              height: null,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    spacingheight20,
                    ButtonBar(
                      alignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            isVisbleLegend = !isVisbleLegend;
                            setState(() {
                              tab = 1;
                            });
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.edit_calendar_rounded),
                              Text('Cronograma'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            tab = 2;
                            setState(() {});
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.safety_divider_outlined),
                              Text('Pagos'),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            tab = 3;
                            setState(() {});
                          },
                          child: const Column(
                            children: [
                              Icon(Icons.verified),
                              Text('Asistencias'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    //statictics
                     HorasExtraxStatictis(
                            isVisbleLegend: isVisbleLegend, widget: widget, tab: tab,),
  
                    _expandTitleCard(
                      'Actividad',
                      SvgPicture.asset(AssetsDataSVG.home),
                      [],
                    ),
                    _expandTitleCard(
                        'Team',
                        SvgPicture.asset(
                          AssetsDataSVG.categoria,
                          // ignore: deprecated_member_use
                          color: kfontNavPinkcolor,
                        ),
                        [
                          Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: kfont3erColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: BubbleLens(
                                size: 60,
                                paddingX: 5,
                                paddingY: 5,
                                width: size.width,
                                height: 300,
                                widgets: [
                                  ...widget.listusers.recursoList
                                      .map((e) => CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(e.image),
                                            child: InstaImageViewer(
                                                child: Image.network(
                                              e.image,
                                            )),
                                          ))
                                ]),
                          ),
                        ]),
                    _expandTitleCard('Herramientas',
                        SvgPicture.asset(AssetsDataSVG.configuracion), [
                      TextButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const UsuariogestionPage()));
                        },
                        child: Column(
                          children: [
                            SvgPicture.asset(AssetsDataSVG.user),
                            const Text('Gestionar Usuarios'),
                          ],
                        ),
                      ),
                    ]),
                    _expandTitleCard('Cerrar la sesión',
                        SvgPicture.asset(AssetsDataSVG.pdf), [
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                              (route) => false);
                        },
                        child: Column(
                          children: [
                            LottieBuilder.asset(
                              AssetsDataLoties.intro1,
                              width: 100,
                            ),
                            SvgPicture.asset(AssetsDataSVG.almacen),
                            const Text('Cerrar la sesión'),
                          ],
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _expandTitleCard(String title, Widget leading, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: ExpansionTileCard(
          leading: ClipRRect(
              borderRadius: BorderRadius.circular(10), child: leading),
          title: H1(
              fontSize: 15,
              text: title,
              textColor: kfont3erColor),
          children: children),
    );
  }
}

class HorasExtraxStatictis extends StatelessWidget {
   HorasExtraxStatictis({
    super.key,
    required this.isVisbleLegend,
    required this.widget,
    required this.tab
  });

  final bool isVisbleLegend;
  final NavPerfilPage widget;
  int tab=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       tab==1 ? SfCartesianChart(
            title: ChartTitle(
                text: 'Horas extras',
                textStyle: TextStyle(
                  color: kfontNavBackgroundColor,
                )),
            legend: Legend(isVisible: isVisbleLegend),
            tooltipBehavior: TooltipBehavior(
              color: kfont3erColor,
              enable: true,
            ),
            enableAxisAnimation: true,
            isTransposed: true, //Invierte el grafico
            plotAreaBackgroundColor: Colors.white,
            backgroundColor: Colors.transparent,
            primaryXAxis: CategoryAxis(
                isVisible: true,
                maximum: 19,
                // minimum: 19,
                maximumLabels: 0,
                // title: !isVisbleLegend ? AxisTitle():AxisTitle(text: 'Nombre'),
                visibleMaximum: 15,
                visibleMinimum: 0,
                interval: 1,
                arrangeByIndex: false),
            borderColor: Colors.white,
            plotAreaBorderColor: Colors.black12,
            // plotAreaBorderWidth: 1,
            // plotAreaBackgroundImage: const AssetImage(AssetsData.andeanLodges),

            series: <ChartSeries<User, String>>[
              // LineSeries
              ColumnSeries<User, String>(
                  dataSource: widget.listusers.recursoList,
                  emptyPointSettings: EmptyPointSettings(
                      mode: EmptyPointMode.average, color: Colors.orange),
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    borderColor: Colors.indigo,
                  ),
                  xValueMapper: (User data, _) {
                    return data.role;
                  },
                  yValueMapper: (User data, _) => data.calification,
                  color: kfontNavPinkcolor.withOpacity(.8),
                  name: 'Roles',
                  // Enable data label
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                  )),
              ColumnSeries<User, String>(
                  dataSource: widget.listusers.recursoList,
                  xValueMapper: (User data, _) =>
                      '${data.id} •${data.nombreCompleto}',
                  yValueMapper: (User data, _) => data.calification,
                  name: 'Usuarios',
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    borderColor: Colors.greenAccent,
                  ),
                  color: Colors.green.withOpacity(.5),
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    // alignment: ChartAlignment.far
                  )),
            ]) : spacingheight10,
        tab == 2 ? SfPyramidChart(
            tooltipBehavior: TooltipBehavior(
              color: kfont3erColor,
              enable: true,
            ),
            selectionGesture: ActivationMode.longPress,
            backgroundColor: const Color.fromARGB(255, 246, 240, 167),
            borderColor: Colors.orangeAccent,
            title: ChartTitle(text: ''),
            enableMultiSelection: true,
            legend: const Legend(isVisible: true),
            series: PyramidSeries<User, String>(
                dataSource: widget.listusers.recursoList,
                xValueMapper: (User data, _) => data.nombreCompleto,
                yValueMapper: (User data, _) => data.calification)): spacingheight10,
       tab ==3 ? SfCartesianChart(legend: const Legend(isVisible: true), series: <ChartSeries>[
          HistogramSeries<User, num>(
              dataSource: widget.listusers.recursoList,
              yValueMapper: (User sales, _) => sales.calification,
              binInterval: 2,
              showNormalDistributionCurve: true,
              curveColor: const Color.fromRGBO(192, 108, 132, 1),
              borderWidth: 3),
        ]) : spacingheight10,
      ],
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
      color: Colors.white,
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
              child: Row(
                children: [
                  H1(
                      fontSize: 18,
                      text: 'Editar',
                      textColor: Colors.white),
                  SvgPicture.asset(
                    AssetsDataSVG.editar,
                    // ignore: deprecated_member_use
                    color: Colors.white,
                    width: 20,
                  )
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
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(usua[index].image))),
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
        // textOverflow: TextOverflow.ellipsis,
        // fontWeight: FontWeight.normal,
        fontSize: ((maxTitleSize - 11) * (1 - percent))
            .clamp(minSubTitleSize, maxSubTitleSize),
        text: text,
        textColor: kfontNavTealcolor);
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
