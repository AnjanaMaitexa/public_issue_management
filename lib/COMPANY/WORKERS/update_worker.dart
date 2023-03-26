
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/Workers/manage_workers.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateWorker extends StatefulWidget {
  const UpdateWorker({Key? key}) : super(key: key);

  @override
  State<UpdateWorker> createState() => _UpdateWorkerState();
}

class _UpdateWorkerState extends State<UpdateWorker> {
  bool _isLoading = false;
  late String name;
  late String address;
  late String phn;
  late SharedPreferences localStorage;
  late String worker_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
/*  Future<void> getLogin() async {
    localStorage = await SharedPreferences.getInstance();
    worker_id = (localStorage.getString('_id') ?? '');
    print('worker_id ${worker_id}');
  }*/
  @override
   initState()  {
    // TODO: implement initState
    super.initState();

    _viewWorker();
  }
  Future<void> _viewWorker() async {
    localStorage = await SharedPreferences.getInstance();
    worker_id = (localStorage.getString('_id') ?? '');
    print('worker_id ${worker_id}');
    var res = await Api().getData('/worker/view-single-worker/' + worker_id);
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      print(name);
      address = body['data']['address'];
      phn = body['data']['phone'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Workers"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ManageWorkers(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "Update Workers",
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
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText:name ,
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
                  controller: addressController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText:address ,
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
                  controller: phnController,
                  decoration: InputDecoration(
                    hintText:phn ,
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ManageWorkers(),));
                    },
                    child: Text(
                      "UPDATE",
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
    );
  }
}
