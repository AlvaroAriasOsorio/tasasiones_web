
import 'package:flutter/material.dart';


class H1 extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const H1({super.key, 
    required this.text,
    this.fontSize = 17.0,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w900,
      ),
      
    );
  }
}

class H2 extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color textColor;

  const H2({super.key, 
    required this.text,
    this.fontSize = 10.0,
    this.textColor = const Color.fromARGB(255, 68, 66, 66),
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
