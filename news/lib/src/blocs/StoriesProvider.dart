import 'package:flutter/material.dart';
import 'package:news/src/blocs/StoriesBloc.dart';

class StoriesProvider extends InheritedWidget {
  final StoriesBloc storiesBloc;

  StoriesProvider({Key key, @required Widget child})
      : storiesBloc = StoriesBloc(),
        assert(child != null),
        super(key: key, child: child);

  static StoriesProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StoriesProvider)
        as StoriesProvider;
  }

  @override
  bool updateShouldNotify(StoriesProvider old) {
    return true;
  }
}
