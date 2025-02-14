import 'package:assabil/pages/home_screen.dart';
import 'package:assabil/pages/introduction/colors.dart';
import 'package:assabil/pages/introduction/home_page.dart';
import 'package:assabil/provider/ordreProvider.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';
import 'pages/ordre_releve.dart';
import 'package:provider/provider.dart';
import 'provider/personProvider.dart';
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PersonProvider()),
        ChangeNotifierProvider(create: (_) => OrderDetailModel()), 
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASSABIL MOBILE',
      theme: ThemeData(
        primaryColor: const Color(0xFF007bff), // Couleur bleue personnalisée
        hintColor: const Color(0xFFfd7e14), // Couleur orange personnalisée
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 30,
          color: MyColors.titleTextColor,
          fontWeight: FontWeight.bold,
          
        ),
        displayMedium: TextStyle(
            fontSize: 18,
            color: MyColors.subTitleTextColor,
            fontWeight: FontWeight.w400,
            wordSpacing: 1.2,
            height: 1.2),
        displaySmall: TextStyle(
          fontSize: 18,
          color: MyColors.titleTextColor,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      primarySwatch: Colors.blue,
      ),
      initialRoute: '/introduction',
      routes: {
        '/home': (context) => HomeScreen(),
        '/login': (context) => Login(controller: PageController()),
        '/relveur': (context) => ReleveurScreen(),
        '/introduction': (context) => HomePage(),


      },
    );
  }
}
