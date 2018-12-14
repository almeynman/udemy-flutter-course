import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;
import 'widgets/ImageList.dart';
import 'models/imageModel.dart';
import 'dart:convert';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  List<ImageModel> imageModels = [];

  void fetchImage() async {
    var nextId = imageModels.length + 1;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$nextId');
    var imageModel = ImageModel.fromJson(json.decode(response.body));
    setState(() {
      imageModels.add(imageModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            title: Text('Let\'s see some images')
        ),
        body: ImageList(imageModels),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: fetchImage,
        ),
      ),
    );
  }
}