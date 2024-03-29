import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PostDetails extends StatelessWidget {
  const PostDetails({
    Key? key,
    required this.title,
    required this.description,
    required this.url,
    required this.name,
  }) : super(key: key);

  final String title;
  final String description;
  final String url;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Post Details')),
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 10),
                child: Image(
                  image: NetworkImage(Uri.parse(url).isAbsolute
                      ? url
                      : 'http://www.cspsroorkee.com/images/principal.jpg'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.deepOrange.shade300,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Flexible(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}