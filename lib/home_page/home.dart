// import 'package:flutter/material.dart';
// import 'package:final_project/user_login/components/body.dart';
// import 'package:final_project/create_post/create-post.dart';

// class HomePageScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         // ListView.builder(
//         //   itemCount: 50,
//         //   itemBuilder: (context, index) {
//         //     return Container(
//         //       height: 30,
//         //       padding: EdgeInsets.symmetric(horizontal: 20),
//         //       child: Text('$index'),
//         //     );
//         //   },
//         // ),
//         Align(
//           alignment: Alignment.bottomRight,
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
//             width: double.infinity,
//             child: MaterialButton(
//               child: Text('+', style: TextStyle(fontSize: 24)),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CreatePostScreen(),
//                   )
//                 );
//               },
//               color: Colors.deepOrange.shade200,
//               textColor: Colors.black,
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }