

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/api.dart';
import 'package:public_issue_management/login.dart';
/*class Comp_Reg extends StatelessWidget {
  const Comp_Reg({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:MyStatefulWidget()
    );
  }
}*/
class Comp_Reg extends StatefulWidget {
  const Comp_Reg({Key? key}) : super(key: key);
 
  @override
  State<Comp_Reg> createState() => _Comp_RegState();
}
 
class _Comp_RegState extends State<Comp_Reg> {
  bool _isLoading = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
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
      "company_name": nameController.text,
      "address": addressController.text,
      "phone": phnController.text,
      "email": emailController.text,
    };
    print(data);
    var res = await Api().authData(data,'/signup/company');
    var body = json.decode(res.body);

    print(body);
    if(body['success']==true)
    {
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
                  decoration: const BoxDecoration(
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

                    const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text( "REGISTER",
                    style:TextStyle(
                      fontSize:20,
                      fontWeight:FontWeight.bold,
                      color:Colors.teal
                    ),),
                  ),
                   const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: nameController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please choose a name to use";
                        }
                      },
                      decoration: InputDecoration(
                        hintText:"Company Name" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: addressController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please choose a address to use";
                        }
                      },
                      maxLines: 2,
                      decoration: InputDecoration(
                        hintText:"Address" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                  // ignore: prefer_const_constructors
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: emailController,
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
                      decoration: InputDecoration(
                        hintText:"Email" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: phnController,
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
                      decoration: InputDecoration(
                        hintText:"Phone" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: usernameController,
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "Please choose a username to use";
                        }
                      },
                      decoration: InputDecoration(
                        hintText:"Username" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: passwordController,
                      validator: (valuePass) {
                        if (valuePass!.isEmpty) {
                          return 'Please enter your Password';
                        }else if(valuePass.length<6){
                          return 'Password too short';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText:"Password" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: confirmController,
                      validator: (valueConPass) {
                        if (valueConPass!.isEmpty) {
                          return 'Please confirm your Password';
                        } else if (valueConPass.length<6) {
                          return 'Please check your Password';
                        }else if (valueConPass == passwordController){
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        hintText:"Confirm Password" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                  const SizedBox(
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
                          registerUser();
                      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                        },
                      child: const Text(
                        "REGISTER",style: TextStyle(fontSize: 18,
                        fontWeight:FontWeight.bold,
                        color: Colors.white),
                      ),

                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child:TextButton(
                        onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));},
                      child: const Text(
                        "Already have an account?Sign Ip!",style: TextStyle(fontSize: 16,
                        color: Colors.teal),
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