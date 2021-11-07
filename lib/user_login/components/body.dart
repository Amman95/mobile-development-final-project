import 'package:final_project/welcome_page/welcome-user.dart';
import 'package:flutter/material.dart';
import 'package:final_project/user_login/components/background.dart';
import 'package:final_project/button/rounded-button.dart';
import 'package:final_project/button/rounded-input-field.dart';
import 'package:web_socket_channel/io.dart';
// import 'package:final_project/home_page/home.dart';

class Body extends StatelessWidget {

  final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  TextEditingController userInput = TextEditingController();

  Body ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides the total height and width for the screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/image/besquare_logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Username",
              onChanged: (userInput) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                _userSignInResponse();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
              },
            )
          ],
        ),
      )
    );
  }

  _userSignInResponse() {
    channel.sink.add('{"type": "sign_in", "data": {"name": "$userInput"}}');
  }
}