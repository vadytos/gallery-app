import 'package:flutter/material.dart';
import 'package:gallery_app/pages/PhotoPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImageList extends StatefulWidget {
  final Uri src;
  ImageList({required this.src, Key? key}) : super(key: key);

  @override
  _ImageListState createState() => _ImageListState(src);
}

class _ImageListState extends State<ImageList> {
  final src;

  _ImageListState(this.src);

  var _data = [];
  bool _mainContentVisible = true;

  void _revokePhotoScreen(BuildContext context, String src, String? title) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PhotoPage(
            url: src,
            title: title,
          ),
        ),
      );

  Future<void> _getImageData() async {
    try {
      var response = await http.get(src);

      _data = json.decode(response.body);

      setState(() {});
    } catch (err) {
      setState(() {
        _mainContentVisible = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _getImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      maintainState: true,
      visible: _mainContentVisible,
      replacement: Center(
        child: Text(
          'Loading failed, sorry',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _data.length,
        itemBuilder: (_, i) => GestureDetector(
          onTap: () => _revokePhotoScreen(
            context,
            _data[i]['urls']['regular'],
            _data[i]['description'],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.black45,
                  width: 2.0,
                ),
              ),
              height: MediaQuery.of(context).size.height / 7,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Image.network(
                        _data[i]['urls']['regular'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(shape: BoxShape.circle),
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Text>[
                          Text(
                            _data[i]['user']['name'],
                            style: Theme.of(context).textTheme.headline6,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            _data[i]['description'] ?? '',
                            style: Theme.of(context).textTheme.subtitle1,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                    flex: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
