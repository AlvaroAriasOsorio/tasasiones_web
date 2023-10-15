import 'package:crud_sheety/UI/general/general.dart';
import 'package:flutter/material.dart';

InputDecoration decorationinputtext(String hintText, String? labeltext) {
  return InputDecoration(
    enabledBorder: outlineInputBorder(),
    focusedBorder: outlineInputBorder(),
    errorBorder: outlineInputBorder(),
    border: outlineInputBorder(),
    disabledBorder: outlineInputBorder(),
    focusedErrorBorder: outlineInputBorder(),
    hintText: hintText,
    labelText: labeltext,
    // fillColor: Colors.red,
    // filled: true,
    labelStyle:  TextStyle(
      fontSize: 12,
      color: kfontPrimaryColor.withOpacity(.6)
    ),
    hintStyle: TextStyle(
      fontSize: 12,
      color: kfontPrimaryColor.withOpacity(.5),
    ),
  );
}

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide:
        BorderSide(color: kfontSecondaryColor.withOpacity(.5), width: .5),
  );
}
