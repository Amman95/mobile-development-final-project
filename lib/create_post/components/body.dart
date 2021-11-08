import 'package:final_project/cubit/main-cubit.dart';
import 'package:final_project/home_page/home.dart';
// import 'package:final_project/welcome_page/components/background.dart';
import 'package:flutter/material.dart';
// import 'package:final_project/welcome_page/welcome-user.dart';
// import 'package:final_project/button/rounded-button.dart';
// import 'package:final_project/button/rounded-input-field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<CreatePost> {

  final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  TextEditingController postTitle = TextEditingController();
  TextEditingController postDescription = TextEditingController();
  TextEditingController postImageUrl = TextEditingController();
  TextEditingController postUsername = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This size provides the total height and width for the screen
    // return Form(
    //   child: SingleChildScrollView(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       children: <Widget>[
    //         Align(
    //           alignment: Alignment.center,
    //         ),
    //         const Text(
    //           'TITLE', 
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
    //           ),
    //         SizedBox(
    //           width: 300,
    //           child: TextFormField(
    //             textAlign: TextAlign.center,
    //             controller: postTitle,
    //           ),
    //         ),
    //         const Text(
    //           'DESCRIPTION', 
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
    //           ),
    //         SizedBox(
    //           width: 300,
    //           child: TextFormField(
    //             textAlign: TextAlign.center,
    //             controller: postDescription,
    //           ),
    //         ),
    //         const Text(
    //           'IMAGE URL', 
    //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
    //           ),
    //         SizedBox(
    //           width: 300,
    //           child: TextFormField(
    //             textAlign: TextAlign.center,
    //             controller: postImageUrl,
    //           ),
    //         )
    //       ]
    //     )
    //   )
    // );
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, String>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Whats Up!'),
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, top: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TITLE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 20,
                          color: Colors.deepOrange.shade600,
                        )
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: postTitle,
                        ),
                      ),
                      Divider(
                        height: 20.0,
                      ),
                      Text(
                        'DESCRIPTION', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 20,
                          color: Colors.deepOrange.shade600,
                        )
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: postDescription,
                        ),
                      ),
                      Divider(
                        height: 20.0,
                      ),
                      Text(
                        'IMAGE URL', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 20,
                          color: Colors.deepOrange.shade600,
                        )
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          controller: postImageUrl,
                        ),
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<MainCubit>().createPost(
                          postUsername.text,
                          postTitle.text,
                          postDescription.text,
                          postImageUrl.text
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageScreen(),
                          )
                        );
                      }, 
                      child: Text('Post'),
                    )
                  ],
                ),
              ]
            ),
          );
        },
      ),
    );
  }
}