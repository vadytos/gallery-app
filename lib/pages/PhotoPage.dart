import 'package:flutter/material.dart';

class PhotoPage extends StatefulWidget {
  final String url;
  final String? title;
  PhotoPage({required this.url, this.title, Key? key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState(url, title);
}

class _PhotoPageState extends State<PhotoPage> {
  final String url;
  final String? title;
  _PhotoPageState(this.url, this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          title ?? 'Photo',
          style: Theme.of(context)
              .textTheme
              .headline5
              ?.copyWith(color: Colors.white60),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Dismissible(
          key: Key(''),
          background: Container(
            color: Colors.grey[900],
          ),
          direction: DismissDirection.vertical,
          onDismissed: (direction) {
            Navigator.pop(context);
          },
          child: Center(
            child: Image.network(
              url,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, progress) => Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 20,
                ),
              ),
              errorBuilder: (context, error, stackTrace) => Text(
                'Loading error.',
                style: TextStyle(
                  color: Colors.red[800],
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
