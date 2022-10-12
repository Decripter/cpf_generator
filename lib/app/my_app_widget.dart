import 'package:document_manager/app/document_manager/view/document_manager_page.dart';
import 'package:flutter/material.dart';

///App base of aplicattion
class MyAppWidget extends StatelessWidget {
  ///Constructor
  const MyAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.indigo,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
          backgroundColor: Colors.indigo,
        ),
      ),
      home: const DocumentManagerPage(),
    );
  }
}
