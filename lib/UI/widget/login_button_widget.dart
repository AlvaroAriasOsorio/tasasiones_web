import 'package:flutter/material.dart';


class ButtonLogin extends StatelessWidget {
  const ButtonLogin(
      {Key? key, required this.onTap, required this.text, this.left = true})
      : super(key: key);

 final VoidCallback onTap;
 final String text;
 final bool left;

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
            color: const Color.fromARGB(255, 209, 111, 25),
            boxShadow: const [
              BoxShadow(
                  offset: Offset.zero, blurRadius: 10, color: Color.fromARGB(255, 238, 231, 208))
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
