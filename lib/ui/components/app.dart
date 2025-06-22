import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tdd/ui/pages/login/login_presenter.dart';


import 'package:flutter_tdd/ui/pages/pages.dart';

class LoginPresenterViewModel implements LoginPresenter{
  final _emailErrorController = StreamController<String?>();
  final _passwordErrorController = StreamController<String?>();
  final _isValidFormController = StreamController<bool>();
  @override
  void validateEmail(String email) {
    // TODO: implement validateEmail
  }

  @override
  void validatePassword(String password) {
    // TODO: implement validatePassword
  }
  
  @override
  Stream<String?> get emailErrorStream => _emailErrorController.stream;
  
  @override
  Stream<String?> get passwordErrorStream => _passwordErrorController.stream;
  
  @override
  // TODO: implement isFormValidStream
  Stream<bool> get isFormValidStream => _isValidFormController.stream;
  
  @override
  void auth() {}
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final primaryColor = Color.fromRGBO(136, 14, 79, 1);
    final primaryColorDark = Color.fromRGBO(96, 0, 39, 1);
    final primaryColorLight = Color.fromRGBO(188, 71, 123, 1);
    return MaterialApp(
      title: '4dev',
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryColorDark,
        primaryColorLight: primaryColorLight,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
          titleMedium: TextStyle(
            color: Theme.of(context).primaryColorLight,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          titleSmall: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w300,
            fontSize: 15,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          alignLabelWithHint: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: primaryColorDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: primaryColorDark),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.light(primary: primaryColor),
          buttonColor: primaryColor,
          splashColor: primaryColorLight,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,

      home: LoginPage(LoginPresenterViewModel()),
    );
  }
}
