import 'package:assabil/pages/MyOCR.dart';
//import 'package:assabil/pages/Synch_export.dart';
import 'package:assabil/pages/acceuil.dart';
import 'package:flutter/material.dart';
import '../pages/login.dart';
import 'package:provider/provider.dart';
import '../provider/personProvider.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<PersonProvider>(
        builder: (context, personProvider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    UserAccountsDrawerHeader(
                      currentAccountPicture: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/Releveur.png'),
                            
                        backgroundColor: Colors.black,
                        radius: 2, // Adjust the radius as needed
                      ),
                      accountEmail: Text(
                        '${personProvider.person.phone} (${personProvider.person.profileCode})',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255), // Change color as needed
                          fontWeight:
                              FontWeight.bold, // Make the phone number bold
                        ),
                      ),
                      accountName: Text(
                        'Bienvenue, ${personProvider.person.name}',
                        style: TextStyle(fontSize: 24.0),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                    ),
                   
                   
                   
                    const SizedBox(height: 20),
                    buildListTile(
                      title: 'Acceuil',
                      icon: Icons.home,
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    buildListTile(
                      title: 'Paramètre',
                      icon: Icons.settings,
                       onTap: () {},
                    ),
                    const Divider(
                      color: Color.fromARGB(248, 235, 235, 235),
                      height: 20,
                      thickness: 2,
                      indent: 50,
                      endIndent: 50,
                    ),
                    buildListTile(
                      title: 'Synchronisation import',
                      icon: Icons.arrow_downward,
                      onTap: () {},
                    ),
                    buildListTile(
                      title: 'Synchronisation export',
                      icon: Icons.arrow_upward,
                      onTap: () {Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );},
                    ),
                  ],
                ),
              ),
              buildListTile(
                title: 'Déconnexion',
                icon: Icons.exit_to_app,
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(controller: PageController()),
                    ),
                    (route) => false, // Remove all routes from the stack
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  ListTile buildListTile(
      {required String title,
      required IconData icon,
      required void Function() onTap}) {
    return ListTile(
      title: Text(title),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
        child: Center(
          child: Icon(icon, color: Colors.white),
        ),
      ),
      onTap: onTap,
    );
  }
}
