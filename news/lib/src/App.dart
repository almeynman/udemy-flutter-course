import 'package:flutter/material.dart';
import 'package:news/src/blocs/StoriesProvider.dart';
import 'package:news/src/blocs/comments_provider.dart';
import 'package:news/src/screens/NewsList.dart';
import 'package:news/src/screens/news_detail.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: 'News',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (context) {
          final storiesBloc = StoriesProvider.of(context).storiesBloc;
          storiesBloc.fetchTopIds();
          return NewsList();
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        final commentsBloc = CommentsProvider.of(context).bloc;
        final itemId = int.parse(settings.name.replaceFirst('/', ''));

        commentsBloc.fetchItemWithComments(itemId);

        return NewsDetail(itemId: itemId);
      });
    }
  }
}
