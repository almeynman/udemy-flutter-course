import 'package:flutter/material.dart';
import 'package:news/src/blocs/comments_bloc.dart';

class CommentsProvider extends InheritedWidget {
  final CommentsBloc bloc;

  CommentsProvider({Key key, @required Widget child})
      : bloc = CommentsBloc(),
        assert(child != null),
        super(key: key, child: child);

  static CommentsProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(CommentsProvider)
        as CommentsProvider;
  }

  @override
  bool updateShouldNotify(CommentsProvider old) {
    return true;
  }
}
