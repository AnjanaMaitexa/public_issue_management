

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/api.dart';
import 'package:public_issue_management/login.dart';


class Dep_Reg extends StatefulWidget {
  const Dep_Reg({Key? key}) : super(key: key);
 
  @override
  State<Dep_Reg> createState() => _Dep_RegState();
}
 
class _Dep_RegState extends State<Dep_Reg> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    nameController.dispose();
    addressController.dispose();
    phnController.dispose();
    emailController.dispose();
    confirmController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void registerUser()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "username": userController.text,
      "password": passwordController.text,
      "department_name": nameController.text,
      "address": addressController.text,
      "phone": phnController.text,
      "email": emailController.text,
      "description": descController.text,
    };
    var res = await Api().authData(data,'/signup/department');
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/back.jpg'),
                      fit: BoxFit.cover ),
                  ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                  const Padding(
                  padding: EdgeInsets.only(top: 30.0),
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
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please choose a name to use";
                      }
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText:"DepartmentName" ,
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
                 SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child:TextFormField(
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
                 SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child:TextFormField(
                    controller: descController,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please choose a description to use";
                      }
                    },
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:"Description" ,
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
                    controller: userController,
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
                 SizedBox(
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
                    obscureText: true,
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
                    validator: (valuePass) {
                      if (valuePass!.isEmpty) {
                        return 'Please enter your Password';
                      }else if(valuePass.length<6){
                        return 'Password too short';
                      } else {
                        return null;
                      }
                    },
                    controller: confirmController,
                    obscureText: true,
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
                        setState(() {
                          registerUser();
                        });
                   //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
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
                  child:TextButton(
                      onPressed: (){

                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                      },
                    child: Text(
                      "Already have an account?Sign Ip!",style: TextStyle(fontSize: 16,
                      color: Colors.teal),
                    ),

                    ),
                  ),
              ],

            ),
          ),
        ),
      ),
   
    );
  }
  }