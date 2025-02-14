import 'dart:math';
import 'package:flutter/material.dart';
import '../components/app_colors.dart';
import '../components/widget_login.dart';
import '../components/AwesomeDialogUtil.dart';
import '../models/person.dart';
import '../business/auth.dart';
import 'package:provider/provider.dart';
import '../provider/personProvider.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.controller}) : super(key: key);
  final PageController controller;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final Authentication authentication = Authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return SizedBox.fromSize(
      size: MediaQuery.of(context).size,
      child: Stack(
        children: [
          Positioned(
            left: 50,
            top: 0,
            child: Transform.rotate(
              angle: -pi * 0.05, // Rotation angle
              child: Image.asset(
                'assets/images/login.png',
                width: 600,
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.whiteColor.withOpacity(.8),
                ),
                child: _buildLoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginForm() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildLogo(),
            const Divider(
              color: Color.fromARGB(248, 235, 235, 235),
              height: 20,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            const SizedBox(height: 10),
            buildTitle(),
            const SizedBox(height: 20),
            buildEmailField(_emailController),
            const SizedBox(height: 10),
            buildPasswordField(_passController),
            const SizedBox(height: 25),
            buildLoginButton(onPressed: () async {
              if (formKey.currentState!.validate()) {
                Person? person = await authentication.authenticateUser(
                  _emailController.text,
                  _passController.text,
                );

                if (person != null) {
                  Provider.of<PersonProvider>(context, listen: false).setPerson(person);
                  await Navigator.pushReplacementNamed(context, '/home');
                } else {
                  await AwesomeDialogUtil.showError(
                      context, 'Erreur', 'Identifiants incorrects');
                }
              }
            }),
            const SizedBox(height: 15),
            buildForgotPasswordText(),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
