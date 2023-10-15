
import 'package:flutter/material.dart';
import 'dart:ui';

// ignore: must_be_immutable
class CardBlurWidget extends StatelessWidget {
  CardBlurWidget(
      {super.key,  
      required this.ruta,
      this.colorblur,
      this.child,
      this.height,
      this.width,
      this.ontap
      });
  Widget ruta;
  Color? colorblur;
  Function? ontap;
  Widget? child;
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ruta));
      },
      child: BlurWidget(height: height, colorblur: colorblur, child: child),
    );
  }
}

class BlurWidget extends StatelessWidget {
  const BlurWidget({
    Key? key,
    required this.height,
    this.width,
    required this.colorblur,
    required this.child,
  }) : super(key: key);

  final double? height;
  final Color? colorblur;
  final Widget? child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: colorblur,
              borderRadius: BorderRadius.circular(20),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
