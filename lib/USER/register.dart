

import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/api.dart';
import 'package:public_issue_management/login.dart';


class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
  return const MaterialApp(
    debugShowCheckedModeBanner: false,
      home:MyStatefulWidget()
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _isLoading = false;

  _pressCreateAccountButton()
  {
    registerUser();

  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
    phnController.dispose();
    emailController.dispose();
    confirmController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "username": usernameController.text,
      "password": passwordController.text,
      "name": nameController.text,
      "address": addressController.text,
      "phone": phnController.text,
      "email": emailController.text,
    };
    var res = await Api().authData(data,'/signup/user');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/back.jpg'),
                      fit: BoxFit.cover ),
                  ),
                  child: ListView(
                    children: [
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

            Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Text( "REGISTER",
            style:TextStyle(

              fontSize:20,
              fontWeight:FontWeight.bold,
              color:Colors.teal
            ),),
          ),
           SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Please choose a name to use";
                }
              },
              controller: nameController,
              decoration: InputDecoration(
                hintText:"Name" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
           SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              validator: (value){
              if(value == null || value.isEmpty){
                return "Please choose a address to use";
              }
            },
              controller: addressController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText:"Address" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
                validator: (valueMail) {
                  if (valueMail!.isEmpty) {
                    return 'Please enter Email Id';
                  }
                  RegExp email = new RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                  if (email.hasMatch(valueMail)) {
                    return null;
                  } else {
                    return 'Invalid Email Id';
                  }
                },
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                hintText:"Email" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
           SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Mobile Number';
                }
                RegExp number = new RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
                if (number.hasMatch(value)) {
                  return null;
                } else {
                  return 'Invalid Mobile Number';
                }
              },
              keyboardType: TextInputType.number,
              controller: phnController,
              decoration: InputDecoration(
                hintText:"+91" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              validator: (value){
              if(value == null || value.isEmpty){
                return "Please choose a username to use";
              }
            },
              controller: usernameController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText:"Username" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
           SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              obscureText: true,
              validator: (valuePass) {
                if (valuePass!.isEmpty) {
                  return 'Please enter your Password';
                }else if(valuePass.length<6){
                  return 'Password too short';
                } else {
                  return null;
                }
              },
              controller: passwordController,
              decoration: InputDecoration(
                hintText:"Password" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
           SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              obscureText: true,
              validator: (valueConPass) {
                if (valueConPass!.isEmpty) {
                  return 'Please confirm your Password';
                } else if (valueConPass.length<6) {
                  return 'Please check your Password';
                }else if (valueConPass == passwordController){
                  return null;
                }
              },
              controller: confirmController,
              decoration: InputDecoration(
                hintText:"Confirm Password" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.teal
              ),
              height: 40,
              //width: 200,
              child: TextButton(
                onPressed: (){
               //   if (_formkey.currentState.validate()) {
                    registerUser();
                //  };

                //  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                },
              child: Text(
                "REGISTER",style: TextStyle(fontSize: 18,
                fontWeight:FontWeight.bold,
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
            child:RichText(
               text: TextSpan(
        text: 'Already have an account?',
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: <TextSpan>[
            TextSpan(text: ' Sign In',
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                        Navigator.of(                                                                                                                                                                                           context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                }
            )
        ]
    ),

              ),
            ),
        ],

      ),
                      ),
                    ],
                  ),
      ),
    );
  }
}