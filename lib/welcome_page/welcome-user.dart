import 'package:flutter/material.dart';
import 'package:final_project/welcome_page/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key, String? title }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}