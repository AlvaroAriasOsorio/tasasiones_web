import 'dart:math';

import 'package:crud_sheety/UI/general/colors.dart';
import 'package:crud_sheety/UI/general/spaicing.dart';
import 'package:crud_sheety/UI/widget/widget.dart';
import 'package:flutter/material.dart';

class AnimationControllerTest extends StatefulWidget {
  const AnimationControllerTest({super.key});

  @override
  State<AnimationControllerTest> createState() =>
      _AnimationControllerTestState();
}

class _AnimationControllerTestState extends State<AnimationControllerTest> {
  Offset offset = Offset.zero;
  int i = 1;
  final double _targetSize = 300;
  double _targetPosition = 0.0;
  @override
  Widget build(BuildContext context) {
    // final productProvider = Provider.of<ProductoProvider>(context);
    // List<Producto> product = productProvider.productoList;

    return Scaffold(
      backgroundColor: kfont3erColor,
      // appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              spacingheight10,
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 1.1, end: _targetPosition),
                duration: const Duration(milliseconds: 8000),
                curve: Curves.fastOutSlowIn,
                // onEnd: (){
                //   if (_targetPosition == 0) {
                //     _targetPosition =1;
                //   } else {
                //     _targetPosition = 0;
                //   }
                // },
                builder: (context, value, child) {
                  return BlurWidget(
                    height: 300,
                    colorblur: Colors.black,
                    child: Stack(
                      children: [
                        Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, .001)
                              ..rotateY(pi * value),
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(20),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    image: value < 0.5
                                        ? const NetworkImage(
                                            'https://cuantoestaeldolar.pe/blog/wp-content/uploads/2019/06/billete-de-100.jpg')
                                        : const NetworkImage(
                                            'https://live.staticflickr.com/3117/3178080785_feffcda270_b.jpg'),
                                  )),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_targetPosition == 0) {
                                      _targetPosition = 1;
                                      setState(() {});
                                    } else {
                                      _targetPosition = 0;
                                      setState(() {});
                                    }
                                  },
                                )
                              ],
                            )),
                      ],
                    ),
                  );
                },
              ),
              BlurWidget(
                colorblur: Colors.black,
                height: null,
                child: Column(
                  children: [
                    Transform(
                      transform: Matrix4.identity()
                       //matriz 2x3 - perspectiva
                        ..setEntry(2, 3, .0005)
                        ..rotateX(0.01 * offset.dx)
                        ..rotateY(0.001 * offset.dy)
                        ..rotateZ(0.01 * offset.dy),
                      //importante hacer que se mueva solo en el centro de la pantalla
                      alignment: Alignment.center,
                      child: GestureDetector(
                        //rotar en el eje x y y
                        onPanUpdate: (details) {
                          setState(() {
                            offset += details.delta;
                          });
                        },
                        //regresar a su estado inicial
                        onDoubleTap: () {
                          setState(() {
                            offset = Offset.zero;
                          });
                        },
                        child: Image.network(
                          'https://static.vecteezy.com/system/resources/previews/008/541/906/non_2x/full-moon-seen-with-telescope-transparent-png.png',
                          width: 250,
                        ),
                      ),
                    ),
                    Image.network(
                        'https://res.cloudinary.com/dw2vwrqem/image/upload/v1676921694/andean%20lodges/Ausangate-Lodge-to-Lodge-1024x564-removebg-preview_jotdh5.png')
                  ],
                ),
              ),
              spacingheight10,
              TweenAnimationBuilder(
                duration: const Duration(seconds: 2),
                tween: Tween<double>(begin: 50, end: _targetSize),
                curve: Curves.easeIn,
                // onEnd: () {
                //   setState(() {
                //     if (_targetSize == 50) {
                //       _targetSize = 300;
                //     } else {
                //       _targetSize = 50;
                //     }
                //   });
                // },
                builder: (BuildContext context, dynamic value, Widget? child) {
                  return Container(
                    width: value,
                    height: value,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image:
                            DecorationImage(image: AssetImage('assets/sol.png'))),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () {
      //         i++;
      //         setState(() {});
      //       },
      //       child: Icon(Icons.arrow_drop_up),
      //     ),
      //     spacingheight10,
      //     FloatingActionButton(
      //       onPressed: () {
      //         i--;
      //         setState(() {});
      //       },
      //       child: Icon(Icons.arrow_drop_down),
      //     ),
      //   ],
      // ),
    );
  }
}
