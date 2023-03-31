
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/depart_task.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateTask extends StatefulWidget {
  String task_id;

  UpdateTask(this.task_id);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {

  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController desController = TextEditingController();

  String task="";
  String date="";
  String desc="";
  late SharedPreferences localStorage;
  late String department_id;
  late String tasks_id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _viewTask();
  }


  Future<void> _viewTask() async {
    tasks_id = widget.task_id;
    print('tasks_id ${tasks_id}');
    var res = await Api().getData('/task/view-single-task/' + tasks_id);
    var body = json.decode(res.body);
    print(body);
    setState(() {
      task = body['data']['task_name'];
      // print(name);
      date = body['data']['date'];
      desc = body['data']['description'];
      taskController.text=task;
      dateController.text=date;
      desController.text=desc;

    });
  }
  _delete() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {"_id": tasks_id};
    print(data);
    var res =
    await Api().deleteData( '/task/delete-task/' + tasks_id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );


      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Depart_Task()));
      print(body['message']);
    } else {
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
          title: Text("Delete Task"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Depart_Task(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text("Delete Task",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent
                    ),),
                ),

                SizedBox(height: 10,),

                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      hintText: "Task name",
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
                  child: TextField(
                    controller: dateController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Date",
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),

                  ),
                ),   SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: desController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Description",
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
                    height: 50,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: TextButton(
                      onPressed: () {
                       _delete();
                      },
                      child: Text(
                        "Delete",
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