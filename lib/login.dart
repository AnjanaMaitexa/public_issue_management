
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';
import 'package:public_issue_management/dashboard.dart';
import 'package:public_issue_management/forgot_pwd.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String uname="user";
  String cname="company";
  String depart ="depart";

  final email = TextEditingController();
  final pwd = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                top: 60.0,left: 30.0,right: 30.0,bottom: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:<Widget> [
                  Padding(
                    padding: const EdgeInsets.only(top:70.0),
                    child: Text("Login",
                      style:TextStyle(color:Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w700) ,),
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
                    )
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height:80,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:10.0),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            hintText: "Email/Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: pwd,
                          decoration: InputDecoration(
                            hintText: "Password",
                            suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.black54,),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                         // obscureText: _obscureText,
                        ),

                      ),
                      SizedBox(
                        height:20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:20.0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Forgot(),));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(fontSize: 16, color: Colors.lightBlueAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.lightBlueAccent),
                          height:50,
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            onPressed: () {
                              if(pwd.text=="user"){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => User_board(),));
                              }else if(pwd.text=="company"){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Dashboard(),));
                              }else if(pwd.text=="depart"){
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Depart_Board(),));
                              }
                             /* Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Depart_Board(),));*/
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
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\t have an account?',
                              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                    text: ' Sign Up',
                                    style:
                                    TextStyle(color: Colors.blueAccent, fontSize: 16),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(MaterialPageRoute(
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
    );
  }
}
