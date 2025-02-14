import 'package:flutter/material.dart';
import '../components/app_colors.dart';

Widget buildLogo() {
  return Positioned(
    left: 50,
    top: 0,
    bottom: 0,
    child: Image.asset(
      'assets/images/Logo_Assabil_bg.png',
      width: 150,
    ),
  );
}

Widget buildTitle() {
  return Text(
    'AUTHENTIFICATION',
    style: TextStyle(
      color: Color.fromARGB(129, 5, 88, 156),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget buildEmailField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    decoration: const InputDecoration(
      labelText: 'Matricule',
      prefixIcon: Icon(Icons.person),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer votre Matricule';
      }
      return null;
    },
  );
}

Widget buildPasswordField(TextEditingController controller) {
  return TextFormField(
    controller: controller,
    obscureText: true,
    decoration:const InputDecoration(
      labelText: 'Mot de passe',
      prefixIcon: Icon(Icons.lock),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Veuillez entrer votre Mot de passe';
      }
      return null;
    },
  );
}

Widget buildLoginButton({required Function()? onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50.0),
      ),
      onPressed: onPressed,
      child: const Text(
        "Connexion",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
    );
  }

Widget buildForgotPasswordText() {
  return Text(
    'Mot de passe oublié?',
    style: TextStyle(
      color: AppColors.primaryHighContrast,
      fontSize: 13,
      fontWeight: FontWeight.w500,
    ),
  );
}
