import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage>{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "About BeSquareBook",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Image.asset(
            "assets/image/besquare_logo.png",
            height: 150,
          ),
          Text(
            "Greetings from BeSquareBook! This app was created in 2021 to make social life much easier virtually!"
          )
        ],
      ),
    );
  }
}