import 'package:flutter/material.dart';
import 'package:flutter_tdd/ui/pages/pages.dart';

class App extends StatelessWidget{
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '4dev',
      debugShowCheckedModeBanner: false,
      
      home: LoginPage(),);
  }
  
}