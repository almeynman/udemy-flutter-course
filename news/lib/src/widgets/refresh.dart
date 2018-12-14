import 'package:flutter/material.dart';
import 'package:news/src/blocs/StoriesProvider.dart';

class Refresh extends StatelessWidget {
  final Widget child;

  Refresh({this.child});

  @override
  Widget build(BuildContext context) {
    final storiesBloc = StoriesProvider.of(context).storiesBloc;

    return RefreshIndicator(
      child: child,
      onRefresh: () async {
        await storiesBloc.clearCaches();
        await storiesBloc.fetchTopIds();
      },
    );
  }
}
