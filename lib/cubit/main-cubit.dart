import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'dart:convert';

class MainCubit extends Cubit<String> {
  MainCubit() : super('');
  List posts = [];
  var username = '';
  dynamic decodedMessage;

  final channel = IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  void openChannel() {
    channel.stream.listen((message) {
      decodedMessage = jsonDecode(message);
      print(decodedMessage);
    });
  }

  void userLogin(String username) {
    channel.sink.add('{"type": "sign_in", "data": {"name": "$username"}}');
    print(username);
  }

  void viewPost(String id, String title, String description, String image, String date, String author) {
    channel.sink.add('{"type": "get_posts"}');
  }

  void createPost(String username, String title, String description, String image) {
    print(username);
    channel.sink.add('{"type": "sign_in", "data": {"name": "$username"}}');
    channel.sink.add('{"type": "create_post", "data": {"title": "$title", "description": "$description", "image": "$image"}}');
  }

  // void deletePost(String postId) {
  //   channel.sink.add('{"type": "delete_post", "data": {"postId": "$postId"}}');
  // }

  String getName() {
    return state;
  }
}