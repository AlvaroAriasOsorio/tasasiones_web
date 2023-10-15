import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ButtonLogin extends StatelessWidget {
  ButtonLogin(
      {Key? key, required this.onTap, required this.text, this.left = true})
      : super(key: key);

  VoidCallback onTap;
  String text;
  bool left;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 25),
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            boxShadow: const [
              BoxShadow(
                  offset: Offset(1.5, 1.5), blurRadius: 10, color: Colors.white12)
            ],
            borderRadius: BorderRadius.circular(15),
            
          ),
          child: Center(
            child: Text(text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                          color: Colors.white,
                          offset: Offset(0, 2),
                          blurRadius: 10),
                    ])),
          ),
        ));
  }
}
