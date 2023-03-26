
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:public_issue_management/dashboard.dart';
import 'package:public_issue_management/forgot_pwd.dart';
import 'package:public_issue_management/login.dart';
import 'package:public_issue_management/splash_screen.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/splash_screen',
        routes: {

          '/splash_screen': (BuildContext context) => SplashScreen(),
          '/forgot_pwd': (context) => Forgot(),
          '/dashboard': (context) => MainDash(),
        }
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
 final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => LoginPage()
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: Image.asset("images/logo.png"),
                ),
                Text("VoiceOut",  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
                ),
              ]
          ),
      ),
    );
  }
}*/
