import 'package:flutter/material.dart';
import 'page/main_page.dart'; // Ensure the import path is correct based on your project structure

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(), // Navigate to the MainPage
    );
  }
}
