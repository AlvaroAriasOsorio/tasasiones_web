// ignore_for_file: non_constant_identifier_names

import 'package:crud_sheety/UI/general/general.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:crud_sheety/utils/text_custom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavAlmacenPage extends StatefulWidget {
  const NavAlmacenPage({super.key});

  @override
  State<NavAlmacenPage> createState() => _NavAlmacenPageState();
}

class _NavAlmacenPageState extends State<NavAlmacenPage>
    with SingleTickerProviderStateMixin {
  int position = 0;
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  List<Color> colors = [Colors.brown, Colors.cyan, Colors.orange];
  double valor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Image.asset(
              AssetsData.andeanLodges,
              color: colors[position],
            ),
          ],
          title: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 1200),
            tween: Tween(begin: 0, end: 1),
            curve: Curves.fastOutSlowIn, // Curves.bounceOut,
            builder: (BuildContext context, value, _) {
              valor = value;
              return Transform.translate(
                offset: Offset((-100.0 * value) + 100, 0),
                child: Opacity(
                  opacity: (value).clamp(0.0, 1.0),
                  child: H1(
                    text: 'Almacén',
                    textColor : kfont3erColor,
                    fontSize: 25,
                  ),
                ),
              );
            },
          ),
          bottom: TabBar(
            indicatorColor: kfont3erColor,
            unselectedLabelColor: kfont3erColor,
            labelColor: kfontNavPinkcolor,
            onTap: (value) {
              position = value;
              setState(() {});
            },
            tabs: [
              Tab(
                text: 'Equipos',
                icon: _Svg(AssetsDataSVG.almacen, 0),
              ),
              Tab(
                text: 'Productos',
                icon: _Svg(AssetsDataSVG.tenedor, 1),
              ),
              Tab(
                text: 'Medicamentos',
                icon: _Svg(AssetsDataSVG.categoria, 2),
              ),
            ],
            controller: _tabController,
          ),
        ),
        body: TweenAnimationBuilder<double>(
          tween: Tween(begin: 1, end: 0),
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn, //Curves.elasticOut,
          builder: (context, value, _) {
            return Transform.translate(
              offset: Offset(100 * value, -100 * value),
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0),
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    EquiposAlmacen(
                      valor: valor,
                    ),
                    EquiposAlmacen(
                      valor: valor,
                    ),
                    EquiposAlmacen(
                      valor: valor,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  SvgPicture _Svg(String svgImage, int positionElement) => SvgPicture.asset(
        svgImage,
        // ignore: deprecated_member_use
        color: position == positionElement
            ? kfontNavPinkcolor
            : kfontNavBackgroundColor,
      );
}

// ignore: must_be_immutable
class EquiposAlmacen extends StatelessWidget {
  EquiposAlmacen({super.key, required this.valor});
  double valor;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
         spacingheight100,

          // ...List.generate(
          //   pageRoutesAlmacen.length,
          //   (index) => GestureDetector(
          //     child: ExpansionTileCard(
          //       leading: Transform.rotate(
          //         angle: 360 * valor,
          //         child: CircleAvatar(
          //           backgroundColor: Colors.black,
          //           child: Icon(Icons.accessibility_new_sharp),
          //         ),
          //       ),
          //       title: TextStyleUi(
          //         fontWeight: FontWeight.normal,
          //         size: 18,
          //         text: pageRoutesAlmacen[index].title,
          //         color: kfont3erColor,
          //       ),
          //       children: [
                
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
