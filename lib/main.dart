

// import 'package:crud_sheety/UI/pagesModules/usuario_gestion_page.dart';
import 'package:crud_sheety/UI/pages/login_page.dart';
import 'package:crud_sheety/UI/pagesModules/pagina_datatable.dart';
import 'package:crud_sheety/service/service.dart';
import 'package:crud_sheety/service/tasasiones_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider( create: (context)=> MyProvider(),),
        ChangeNotifierProvider(lazy: false,create: (_)=> RecursosProvider()),
        ChangeNotifierProvider(lazy: false,create: (_) => TasasionesProvider())
        // ChangeNotifierProvider(lazy: false,create: (_)=>ProductoProvider()),
      ],
      child: const MyApp() ,
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  const LoginPage(),//const PoketbaseGet (),
      theme: ThemeData.light().copyWith(textTheme: GoogleFonts.poppinsTextTheme())
      );
  }
}
