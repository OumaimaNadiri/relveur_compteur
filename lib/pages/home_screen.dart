import 'package:assabil/pages/acceuil.dart';
import 'package:assabil/pages/analyse.dart';
import 'package:assabil/pages/ordre_releve.dart';
import 'package:flutter/material.dart';
import 'package:assabil/pages/synchronization/screens/dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _getBodyContent(_currentIndex),
      ),
      
    );
  }

  Widget _getBodyContent(int index) {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return ReleveurScreen();
      case 2:
        return Home();
      case 3:
        return DashBoardScreen();
      case 4:
        return DataAnalysisScreen();
      default:
        return Text('Home');
    }
  }
}
