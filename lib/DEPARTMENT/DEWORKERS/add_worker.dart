
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/DEWORKERS/manage_workers.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Addworker extends StatefulWidget {
  const Addworker({Key? key}) : super(key: key);

  @override
  State<Addworker> createState() => _AddworkerState();
}

class _AddworkerState extends State<Addworker> {
  bool _isLoading = false;
  late SharedPreferences localStorage;
  late String login_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  Future<void> getLogin() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('login_id') ?? '');
    print('login_idcompany ${login_id}');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phnController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  void registerWorker()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "company_id":login_id.replaceAll('"', ''),
      "name": nameController.text,
      "address": addressController.text,
      "phone": phnController.text,
    };
    print(data);
    var res = await Api().authData(data,'/worker');
    var body = json.decode(res.body);

    print(body);
    if(body['success']==true)
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>ManageWorkers()));

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Workers"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ManageWorkers(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child:Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text( "Add Workers",
                    style:TextStyle(
                        fontSize:20,
                        fontWeight:FontWeight.bold,
                        color:Colors.lightBlueAccent
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
                      hintText:"Workers Name" ,
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
                  child: TextFormField( validator: (value) {
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
                      hintText:"Phone" ,
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),

                  ),
                ),
                SizedBox(
                  height: 30,
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
                        registerWorker();
                        /* Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ManageWorkers(),));*/
                      },
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
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
