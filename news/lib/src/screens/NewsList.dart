import 'package:flutter/material.dart';
import 'package:news/src/blocs/StoriesBloc.dart';
import 'package:news/src/blocs/StoriesProvider.dart';
import 'package:news/src/widgets/news_list_tile.dart';
import 'package:news/src/widgets/refresh.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context).storiesBloc;
    return Scaffold(
      appBar: AppBar(
        title: Text('Top news'),
      ),
      body: buildList(storiesBloc),
    );
  }

  Widget buildList(StoriesBloc storiesBloc) {
    return StreamBuilder(
      stream: storiesBloc.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Refresh(
          child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index) {
              storiesBloc.fetchItem(snapshot.data[index]);
              return NewsListTile(
                itemId: snapshot.data[index],
              );
            },
          ),
        );
      },
    );
  }
}
