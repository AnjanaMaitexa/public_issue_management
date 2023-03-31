import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/WORKERS/viewwork.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewDetailTask extends StatefulWidget {
  const ViewDetailTask({Key? key}) : super(key: key);

  @override
  State<ViewDetailTask> createState() => _ViewDetailTaskState();
}

class _ViewDetailTaskState extends State<ViewDetailTask> {

  bool _isLoading = false;
  late SharedPreferences localStorage;
  late String login_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();
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

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('login_id') ?? '');
    print('worker_id ${login_id}');
    var res = await Api()
        .getData('/task/worker-view-task/' + login_id.replaceAll('"', ''));
    if (res.statusCode == 200) {
      var body = json.decode(res.body)['data'];
      print(body);
      setState(()  {
     //   _loadedWorkers = body;
        /*  worker_id=int.parse(body['data']['_id']).toString();
        print("worker_id${worker_id}");
       localStorage = await SharedPreferences.getInstance();
        localStorage.setString('_id', worker_id.toString());
*/
      });
    } else {
      setState(() {
       // _loadedWorkers = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("View  Task"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ViewWorkTask(),
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
                child: Text( "View Task",
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
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText:"TenderName" ,
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),

                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: desController,
                  decoration: InputDecoration(
                    hintText:"Description" ,
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  controller: dateController,
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
                      setState(() {
                    //    addTender();
                      });   },
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
    );
  }
}
