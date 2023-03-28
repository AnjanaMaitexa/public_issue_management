import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:public_issue_management/dashboard.dart';
import 'package:public_issue_management/forgot_pwd.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = "2";
  String company = "1";
  String depart = "3";
  String storedvalue = "1";
  late SharedPreferences localStorage;
  String loginId = '';
  String role = '';
  String status = '';
  bool _isLoading = false;
  bool _obscureText = true;
  late String  loginid;

  final email = TextEditingController();
  final pwd = TextEditingController();
  _pressLoginButton() async {
    setState(() {
      _isLoading = true;
    });
    var data = {
      'username': email.text.trim(), //username for email
      'password': pwd.text.trim()
    };
    var res = await Api().authData(data,'/sign_in');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      role = json.encode(body['role']);
      status = json.encode(body['status']);

      localStorage = await SharedPreferences.getInstance();
      localStorage.setString('role', role.toString());
      localStorage.setString('login_id', json.encode(body['login_id']));
      localStorage.setString('department_id', json.encode(body['department_id']));

      print('login_idss ${json.encode(body['login_id'])}');
      print('login_simple ${json.encode(body['department_id'])}');

      /*loginid = (localStorage.getString('login_id') ?? '');
      print(loginid);*/

      //  print('user ${user.runtimeType}');
      //  print('role ${role.runtimeType}');
      // print('user ${user}');
      // print('role ${role}');
      // print("------");
      // print('storedvalue ${storedvalue}');
      // print('status ${status}');
      // print(user == role);
      // print(status == storedvalue);
      if (user == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => User_board()));
      } else if (company == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Dashboard(),
        ));
      } else if (depart == role.replaceAll('"', '') &&
          storedvalue == status.replaceAll('"', '')) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Depart_Board(),
        ));
      } else {
        Fluttertoast.showToast(
          msg: "Please wait for admin approval",
          backgroundColor: Colors.grey,
        );
      }


    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  String _password = "";

  @override
  void dispose() {
    email.dispose();
    pwd.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () => _ExitDialog(context),
        child: Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 70.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w700),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Username",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextField(
                              obscureText: _obscureText,
                              controller: pwd,
                              decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: Icon(
                                  Icons.remove_red_eye_outlined,
                                  color: Colors.black54,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              // obscureText: _obscureText,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Forgot(),
                                ));
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.lightBlueAccent),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.lightBlueAccent),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                onPressed: () {
                                  _pressLoginButton();
                                },
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: RichText(
                              text: TextSpan(
                                  text: 'Don\t have an account?',
                                  style: TextStyle(
                                      color: Colors.lightBlueAccent,
                                      fontSize: 16),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: ' Sign Up',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 16),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) => MainDash(),
                                            ));
                                          })
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _ExitDialog(BuildContext context) {}
}
