import 'package:flutter/material.dart';
import '../models/imageModel.dart';

class ImageList extends StatelessWidget {
  final List<ImageModel> images;

  ImageList(this.images);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (BuildContext context, int index) => buildImage(images[index]),
    );
  }

  Widget buildImage(ImageModel image) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Image.network(image.url),
          ),
          Text(image.title),
        ],
      ),
    );
  }
}
