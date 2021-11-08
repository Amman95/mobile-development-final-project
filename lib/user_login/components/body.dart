import 'package:flutter/material.dart';
import 'package:final_project/user_login/components/background.dart';
import 'package:final_project/button/rounded-button.dart';
import 'package:final_project/button/rounded-input-field.dart';
import 'package:web_socket_channel/io.dart';
import 'package:final_project/home_page/home.dart';
import 'package:final_project/cubit/main-cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class Body extends StatelessWidget {

//   final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

//   TextEditingController userInput = TextEditingController();

//   Body ({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // This size provides the total height and width for the screen
//     return Background(
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "LOGIN",
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
//             ),
//             SizedBox(height: size.height * 0.03),
//             Image.asset(
//               "assets/image/besquare_logo.png",
//               height: size.height * 0.35,
//             ),
//             SizedBox(height: size.height * 0.03),
//             RoundedInputField(
//               hintText: "Your Username",
//               onChanged: (userInput) {},
//             ),
//             RoundedButton(
//               text: "LOGIN",
//               press: () {
//                 if (userInput == null) {
//                   print('Please Enter Your Username!');
//                 } else {
//                   _userSignInResponse();
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                      builder: (context) => HomePageScreen(),
//                     ),
//                   );
//                 }
//               },
//             )
//           ],
//         ),
//       )
//     );
//   }

//   _userSignInResponse() {
//     channel.sink.add('{"type": "sign_in", "data": {"name": "$userInput"}}');
//   }
// }

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
    Size size = MediaQuery.of(context).size;
    // This size provides the total height and width for the screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/image/besquare_logo.png",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            // Expanded(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       RoundedInputField(
            //         hintText: "Your Username",
            //         onChanged: (username) {
            //         },
            //       ),
            //       RoundedButton(
            //         text: "LOGIN",
            //         press: () {
            //           (username.text.isEmpty)
            //           // ignore: unnecessary_statements
            //           ? {print('Please Enter Your Username!')}
            //           // ignore: unnecessary_statements
            //           : {
            //               _signInUser(),
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                 builder: (context) => HomePageScreen(),
            //                 ),
            //               )
            //             };
            //         }
            //       )
            //     ],
            //   ),
            // ),
            RoundedInputField(
              hintText: "Your Username",
              onChanged: (username) {},
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                // (RoundedInputField.text.isEmpty)
                // ? {print('Please Enter Your Username!')}
                // // ignore: unnecessary_statements
                // : {
                    _signInUser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => HomePageScreen(),
                      ),
                    );
                  // };
              }
            )
          ],
        ),
      )
    );
  }
  _signInUser() {
// Sending user sign in request
    context.read<MainCubit>().userLogin(username.text);
  }
}