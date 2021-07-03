import 'package:flutter/material.dart';
import 'package:gallery_app/themes.dart';
import 'pages/MainPage.dart';

class GalleryApp extends StatelessWidget {
  const GalleryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
