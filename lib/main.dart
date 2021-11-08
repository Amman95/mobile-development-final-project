import 'package:final_project/constants.dart';
import 'package:final_project/cubit/main-cubit.dart';
import 'package:final_project/welcome_page/welcome-user.dart';
// import 'package:final_project/user_login/components/body.dart';
// import 'package:final_project/welcome_page/components/body.dart';
// import 'package:final_project/welcome_page/welcome-user.dart';
// import 'package:final_project/user_login/user-login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'dart:convert';
import 'package:final_project/home_page/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BeSquareBook',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => MainCubit(),
        child: UserLogin(),
      ),
    );
  }
}

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  TextEditingController username = TextEditingController();

  final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepOrange.shade100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 60),
            Image.asset(
              "assets/image/besquare_logo.png",
              height: 100,
            ),
            SizedBox(height: 60),
            Container(
              color: Colors.deepOrange.shade50,
              child: TextFormField(
                textAlign: TextAlign.center,
                controller: username,
                decoration: const InputDecoration(
                  hintText: 'Username'
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                (username.text.isEmpty)
                // ignore: unnecessary_statements
                ? {print('Please input your username!')}
                // ignore: unnecessary_statements
                : {
                  _signInUser(),
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => HomePageScreen(),
                    ),
                  )
                };
              },
              child: const Text(
                'Sign-In',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
    _signInUser() {
    // Sending user sign in request
    context.read<MainCubit>().userLogin(username.text);
  }
}
