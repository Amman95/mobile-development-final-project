import 'dart:convert';
import 'package:final_project/cubit/main-cubit.dart';
// import 'package:final_project/welcome_page/welcome-user.dart';
import 'package:flutter/material.dart';
// import 'package:final_project/user_login/components/body.dart';
import 'package:final_project/create_post/create-post.dart';
// import 'package:final_project/user_login/components/body.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/about_page/about-page.dart';
import 'post-details.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:final_project/user_login/user-login.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  TextEditingController username = TextEditingController();
  bool isFavorite = false;
  bool favoriteClicked = false;

  final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  List posts = [];
  List favoritePosts = [];

  void viewPost() {
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      setState(() {
        posts = decodedMessage['data']['posts'];
      });
      channel.sink.close();
    });
    channel.sink.add('{"type": "get_posts"}');

  }

  sortDate() {
    for (int i = 0; i >= posts.length; i++) {}
  }

  @override
  void initState() {
    super.initState();
    viewPost();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        drawer: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.white,
                child: Image.asset(
                  "assets/image/besquare_logo.png",
                  height: 50,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => AboutPageScreen(),
                        ),
                      );
                    }, 
                    child: Text('About BeSquareBook')
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text('Log Out'),
                  )
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (favoriteClicked == true) {
                      favoriteClicked = false;
                    } else {
                      favoriteClicked = true;
                    }
                  });
                },
                icon: Icon(Icons.face_outlined)),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreatePostScreen(),
                  )
                );
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return BlocProvider(
                        create: (context) => MainCubit(),
                        child: BlocBuilder<MainCubit, String>(
                          builder: (context, state) {
                            return AlertDialog(
                              title: const Text("Tips!"),
                              content: Text(
                                  "Tap and hold a post to delete the post"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Ok"),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    });
              },
              icon: Icon(Icons.info),
            ),
          ],
          title: Center(
            child: Text(
              'BeSquareBook',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.deepOrange.shade300,
        ),
        body: (favoriteClicked == false)
            ? BlocBuilder<MainCubit, String>(
                builder: (context, index) {
                  return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 10.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetails(
                                    name: posts[index]['author'],
                                    title: posts[index]['title'],
                                    description: posts[index]['description'],
                                    url: posts[index]['image'],
                                  ),
                                ),
                              );
                              // Move to post details page
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider(
                                      create: (context) => MainCubit(),
                                      child: BlocBuilder<MainCubit, String>(
                                        builder: (context, state) {
                                          return AlertDialog(
                                            title: const Text("Delete Post"),
                                            content: Column(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                TextFormField(
                                                  controller: username,
                                                ),
                                                Text(
                                                    "Do you want to delete this post?"),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    deletePost(
                                                        '${posts[index]['_id']}',
                                                        username.text);

                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(Uri.parse(
                                                    posts[index]['image'])
                                                .isAbsolute &&
                                            posts[index].containsKey('image')
                                        ? '${posts[index]['image']}'
                                        : 'https://image.shutterstock.com/image-vector/no-image-photography-vector-icon-260nw-1736999849.jpg'),
                                  ),
                                  title: Text(
                                    '${posts[index]["title"].toString().characters.take(20)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      'Created by ${posts[index]["author"].toString().characters.take(15)} on ${posts[index]["date"].toString().characters.take(10)}'),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FavoriteButton(
                                          iconSize: 30.0,
                                          valueChanged: (isFavorite) {
                                            setState(() {
                                              isFavorite = true;
                                              if (favoritePosts
                                                  .contains(posts[index])) {
                                                favoritePosts
                                                    .remove(posts[index]);
                                                print('item already added');
                                              } else {
                                                favoritePosts.add(posts[index]);
                                              }
                                              print(favoritePosts);
                                            });
                                          }),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      });
                },
              )
            : BlocBuilder<MainCubit, String>(
                builder: (context, state) {
                  return ListView.builder(
                      itemCount: favoritePosts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 10.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetails(
                                    name: posts[index]['author'],
                                    title: posts[index]['title'],
                                    description: posts[index]['description'],
                                    url: posts[index]['image'],
                                  ),
                                ),
                              );
                              // Move to post details page
                            },
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return BlocProvider(
                                      create: (context) => MainCubit(),
                                      child: BlocBuilder<MainCubit, String>(
                                        builder: (context, state) {
                                          return AlertDialog(
                                            title: const Text("Delete Post"),
                                            content: Column(
                                              // ignore: prefer_const_literals_to_create_immutables
                                              children: [
                                                TextFormField(
                                                  controller: username,
                                                ),
                                                Text(
                                                    "Do you want to delete this post?"),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    deletePost(
                                                        '${posts[index]['_id']}',
                                                        username.text);

                                                    Navigator.of(context).pop();
                                                  });
                                                },
                                                child: Text('Delete'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel"),
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  });
                            },
                            child: Container(
                                padding: EdgeInsets.all(10.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(Uri.parse(
                                                    posts[index]['image'])
                                                .isAbsolute &&
                                            posts[index].containsKey('image')
                                        ? '${posts[index]['image']}'
                                        : 'https://image.freepik.com/free-vector/bye-bye-cute-emoji-cartoon-character-yellow-backround_106878-540.jpg'),
                                  ),
                                  title: Text(
                                    '${posts[index]["title"].toString().characters.take(20)}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      'Created by ${posts[index]["author"].toString().characters.take(15)} on ${posts[index]["date"].toString().characters.take(10)}'),
                                )),
                          ),
                        );
                      });
                },
              ),
      ),
        
        // Align(
        //   alignment: Alignment.bottomRight,
        //   child: Container(
        //     margin: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        //     width: double.infinity,
        //     child: MaterialButton(
        //       child: Text('+', style: TextStyle(fontSize: 24)),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => CreatePostScreen(),
        //           )
        //         );
        //       },
        //       color: Colors.deepOrange.shade200,
        //       textColor: Colors.black,
        //     ),
        //   ),
        // )
    );
  }

  void deletePost(postID, name) {
    try {
      final channel =
          IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

      channel.sink.add('{"type": "sign_in", "data": {"name": "$name"}}');

      channel.sink.add('{"type":"delete_post","data":{"postId":"$postID"}}');
    } catch (e) {
      // Catch error if you are not the owner of the post
    }
  }
}