import 'package:final_project/constants.dart';
import 'package:final_project/welcome_page/components/body.dart';
import 'package:final_project/welcome_page/welcome-user.dart';
import 'package:final_project/user_login/user-login.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

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
      home: WelcomeScreen(),
    );
  }
}

// class UserNameWidget extends StatefulWidget {
//   const UserNameWidget({Key? key}) :super(key: key);

//   @override
//   _UserNameWidget createState() => _UserNameWidget();
// }

// class _UserNameWidget extends State<UserNameWidget> {

//   final userpost_api = WebSocketChannel.connect(Uri.parse('ws://besquare-demo.herokuapp.com'));

//   void initState() {
//     ApiStream();
//   }

//   void ApiStream() {
//     userpost_api.stream.listen((message) {
//       final decodedMessage = jsonDecode(message);

//       print(decodedMessage);
//     });

//     void _getPostResponse() {
//       userpost_api.sink.add('{"type": "get_posts"}');
//     }

//     void _getSignInResponse(String userInput) {
//       userpost_api.sink
//       .add('{"type": "sign_in", "data": {"name": "$userInput"}}');
//     }

//     void _getToPost(String title, String description, String image) {
//       userpost_api.sink.add(
//       '{"type": "create_post", "data": {"title": "$title", "description": "$description", "image": "$image"}}');
//     }

//     void _getTodeletePost(String postId) {
//       userpost_api.sink
//       .add('{"type": "delete_post", "data": {"postId": "$postId"}}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Body();
//     // TODO: implement build
//     throw UnimplementedError();
//   }
// }

