import 'package:animate_do/animate_do.dart';
import 'package:assabil/pages/analyse.dart';
import 'package:assabil/pages/synchronization/animations/fade_in.dart';
import 'package:assabil/pages/synchronization/screens/dashboard.dart';
import 'package:assabil/pages/synchronization/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:assabil/components/drawer.dart';
import 'package:assabil/pages/ordre_releve.dart';
import 'package:flutter/cupertino.dart';
import 'dart:developer';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: MyDrawer(),
      body: Container(
        color: Colors.white.withOpacity(0.1),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
             
             
                 FadeInAnimation(
              delay: 1,
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tue, 2 Jan",
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        "My Day",
                        style: TextStyle(fontSize: 34),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onLongPress: () {
                      log('triggered');
                      setState(() {});
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const ProfilePage(),
                        ),
                      );
                    },
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: Hero(
                        tag: const Key('image'),
                        child: Container(
                          decoration: const ShapeDecoration(
                            shape: StarBorder(
                              innerRadiusRatio: .9,
                              pointRounding: .2,
                              points: 10,
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/Releveur.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),    
                              SizedBox(height: 50),

                 Row(
                children: [
                  Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                 
                ],
              ),
              SizedBox(height: 30),
              
              
              SizedBox(height: 20),
              FadeInUp(
                delay: const Duration(milliseconds: 600),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final items = [
                      {
                        'title': 'Saisie Index',
                        'image': 'assets/images/electric_counter.png',
                        'route': ReleveurScreen()
                      },
                      {
                        'title': 'Synchronization',
                        'image': 'assets/images/sync_home.png',
                        'route': DashBoardScreen()
                      },
                      {
                        'title': 'Reporting',
                        'image': 'assets/images/reporting.png',
                        'route': null
                      },
                      {
                        'title': "Tableau de bord",
                        'image': 'assets/images/dashboard.png',
                        'route': DataAnalysisScreen()
                      },
                    ];

                    final item = items[index];

                    return InkWell(
                      onTap: () {
                        if (item['route'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => item['route'] as Widget),
                          );
                        }
                      },
                      child: FadeInUp(
                        delay: Duration(milliseconds: 600 * index ~/ 1.5),
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                item['image'] as String,
                                height: 80, // Agrandir la taille de l'image
                              ),
                              const SizedBox(height: 10),
                              Text(
                                item['title'] as String,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
