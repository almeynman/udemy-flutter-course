import 'package:flutter/material.dart';
import 'package:news/src/models/ItemModel.dart';
import 'package:news/src/widgets/loading_container.dart';

class Comment extends StatelessWidget {
  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth = 0});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: itemMap[itemId],
      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        var item = snapshot.data;
        final children = <Widget>[
          ListTile(
            title: _buildText(item),
            subtitle: item.by == '' ? Text('Deleted') : Text(item.by),
            contentPadding: EdgeInsets.only(
              right: 16.0,
              left: (depth + 1) * 16.0,
            ),
          ),
          Divider(),
        ];
        snapshot.data.kids.forEach((kidId) {
          children.add(Comment(
            itemId: kidId,
            itemMap: itemMap,
            depth: depth + 1,
          ));
        });

        return Column(
          children: children,
        );
      },
    );
  }

  Widget _buildText(ItemModel item) {
    return Text(
      item.text
          .replaceAll('&#x27;', "'")
          .replaceAll('<p>', '\n')
          .replaceAll('</p>', ''),
    );
  }
}
