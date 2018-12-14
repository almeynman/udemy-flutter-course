import 'package:flutter/material.dart';
import './Bloc.dart';

class Provider extends InheritedWidget {
  final bloc = Bloc();

  Provider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) {
    return true;
  }

  static Bloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}