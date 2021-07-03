import 'package:flutter/material.dart';
import 'package:gallery_app/widgets/ImageList.dart';

class MainPage extends StatelessWidget {
  final src = Uri.parse(
    'http://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery',
          style: Theme.of(context).textTheme.headline4,
        ),
        centerTitle: true,
        elevation: 3.0,
      ),
      body: ImageList(
        src: src,
      ),
    );
  }
}
