
import 'package:crud_sheety/models/model.dart';
import 'package:crud_sheety/models/tasasiones_model.dart';
import 'package:flutter/material.dart';


class UserFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  User userform;

  UserFormProvider(this.userform);

  updateAvailability(bool value){
    // print(value);
    userform.estatus = value;
    notifyListeners();
  }

  bool isValidation(){
    return formKey.currentState!.validate() ;
  }
}


class TasasioneFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Tasasione userform;

  TasasioneFormProvider(this.userform);

  updateAvailability(bool value){
    // print(value);
    userform.estatus = value;
    notifyListeners();
  }

  bool isValidation(){
    return formKey.currentState!.validate() ;
  }
}