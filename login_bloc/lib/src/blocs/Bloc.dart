import 'dart:async';
import 'validators.dart';
import 'package:rxdart/rxdart.dart';

class Bloc extends Object with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);
  Stream<bool> get submitValidStream => Observable.combineLatest2(emailStream, passwordStream, (email, password) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  submit() {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;

    print('Email is $validEmail');
    print('Password is $validPassword');
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
  }
}