
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';
import 'package:public_issue_management/login.dart';
import 'package:public_issue_management/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
enum Role{user,company,depart}
class _SplashScreenState extends State<SplashScreen> {
  late String u="2";
  late String role="";
  late String c="1";
  late String d="3";
  late SharedPreferences localStorage;

  Future<void> checkRoleAndNavigate() async {
    localStorage = await SharedPreferences.getInstance();
    role = (localStorage.getString('role') ?? '');
    print(role);
    if (u == role.replaceAll('"', '')) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => User_board()));
    } else if (c == role.replaceAll('"', '')) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Dashboard(),
      ));
    } else if (d == role.replaceAll('"', '') ) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Depart_Board(),
      ));
    }   else  {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    }
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 4);
    return Timer(duration, checkRoleAndNavigate);
  }

 /* void initState() {
    super.initState();
    Timer(Duration(seconds: 5),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) => checkRoleAndNavigate()
            )
        )
    );
  }*/
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
}
