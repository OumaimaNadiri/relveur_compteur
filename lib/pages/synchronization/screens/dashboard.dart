
import 'package:assabil/components/drawer.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../animations/fade_in.dart';
import '../widgets/app_card.dart';
import '../widgets/increasing_text.dart';
import '../widgets/progress_with_text.dart';
import 'package:assabil/business/sychro.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final Synchronization _synchronization = Synchronization();

  @override
  Widget build(BuildContext context) {
    double w = (MediaQuery.sizeOf(context).width / 2) - 35;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: MyDrawer(),
      body: Column(
        
        children: [
          SizedBox(height: 20,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AppCard(
              height: 175,
              color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Synchronization",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.sync, color: Colors.white),
                        onPressed: () {
                          // Call sync function or any other action
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child:
                              IconButton(
                                icon: Icon(Icons.file_download,
                                size: 40,),
                                color: Colors.green.shade700,
                                highlightColor: Colors.green,
                                onPressed: () {
                                  _showImportDialog(context);
                                },
                              ),
                          
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: 
                              IconButton(
                                icon: Icon(Icons.file_upload,
                                size: 40,),
                                color: Colors.red.shade700,
                                highlightColor: Colors.red,
                                onPressed: () {
                                  //_showExportDialog(context);
                                },
                              ),
                              
                            
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FadeInAnimation(
                    delay: 1,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Etat global des données",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeInAnimation(
                              delay: 1.5,
                              child: AppCard(
                                height: 250,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              "Ordres non saisis",
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                            'assets/icons/thunderbolt.png',
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Expanded(
                                      child: ProgressWithText(
                                        value: 2232,
                                        indicatorValue: .78,
                                        title: 'ordres',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            FadeInAnimation(
                              delay: 2.5,
                              child: AppCard(
                                height: 250,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Ordres saisis",
                                          style: TextStyle(fontSize: 13),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          height: 30,
                                          width: 30,
                                          child: Image.asset(
                                            'assets/icons/thunderbolt.png',
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Expanded(
                                      child: ProgressWithText(
                                        indicatorValue: .78,
                                        title: 'ordres',
                                        value: 553,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: w,
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 1.5,
                              child: AppCard(
                                height: 170,
                                color: Colors.blue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Spacer(),
                                        Icon(Iconsax.edit, color: Colors.white),
                                      ],
                                    ),
                                    const IncreasingText(
                                      98,
                                      isSingle: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        height: .9,
                                      ),
                                    ),
                                    const Text(
                                      "unités de relevé",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            FadeInAnimation(
                              delay: 1.5,
                              child: AppCard(
                                height: 170,
                                color: Colors.green,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Spacer(),
                                        Icon(Iconsax.mobile, color: Colors.white),
                                      ],
                                    ),
                                    const IncreasingText(
                                      10,
                                      isSingle: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        height: .9,
                                      ),
                                    ),
                                    const Text(
                                      "entrées GSM",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            FadeInAnimation(
                              delay: 1.5,
                              child: AppCard(
                                height: 170,
                                color: Colors.orange,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Spacer(),
                                        Icon(Iconsax.gallery, color: Colors.white),
                                      ],
                                    ),
                                    const IncreasingText(
                                      70,
                                      isSingle: true,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        height: .9,
                                      ),
                                    ),
                                    const Text(
                                      "entrées photos",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showImportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Import en cours..."),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Veuillez patienter pendant l'importation..."),
            ],
          ),
        );
      },
    );

    // Appelez la fonction d'importation et fermez la boîte de dialogue une fois terminé
    _synchronization.importDataFromServer().then((_) {
      Navigator.pop(context); // Ferme la boîte de dialogue
      // Afficher une boîte de dialogue de succès
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Importation terminée"),
            content: Text("Les données ont été importées avec succès."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      Navigator.pop(context); // Ferme la boîte de dialogue
      // Afficher une boîte de dialogue d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur d'importation"),
            content: Text("Une erreur est survenue pendant l'importation : $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }

  /*void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Export en cours..."),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text("Veuillez patienter pendant l'exportation..."),
            ],
          ),
        );
      },
    );

    // Appelez la fonction d'exportation et fermez la boîte de dialogue une fois terminé
    _synchronization.exportDataToServer().then((_) {
      Navigator.pop(context); // Ferme la boîte de dialogue
      // Afficher une boîte de dialogue de succès
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Exportation terminée"),
            content: Text("Les données ont été exportées avec succès."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      Navigator.pop(context); // Ferme la boîte de dialogue
      // Afficher une boîte de dialogue d'erreur
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Erreur d'exportation"),
            content: Text("Une erreur est survenue pendant l'exportation : $error"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    });
  }*/
}
