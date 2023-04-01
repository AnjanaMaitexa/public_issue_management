
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/depart_task.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartAddTask extends StatefulWidget {
  const DepartAddTask({Key? key}) : super(key: key);

  @override
  State<DepartAddTask> createState() => _DepartAddTaskState();
}

class _DepartAddTaskState extends State<DepartAddTask> {

  TextEditingController taskController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController desController = TextEditingController();
  List worker = [];
  String? selectworker;
  var dropDownValue;

  late SharedPreferences localStorage;
  late String login_id;
  late String worker_id;
  DateTime selectedDate = DateTime.now();
  bool _isLoading = false;
  late String startDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate='${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchData();
  }

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('department_id') ?? '');
    print('dept_id ${login_id}');
    var res = await Api()
        .getData('/worker/department-view-all-workers/' + login_id.replaceAll('"', ''));

    var body = json.decode(res.body);
    print("response body${body}");
    setState(() {
      worker=body['data'];
      worker_id = body['data'][0]['_id'];
      print("worker${worker}");
      print("worker${worker_id}");
    });

  }

  void _addTask()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "worker_id":worker_id ,
      "department_id":login_id.replaceAll('"', ''),
      "task_name": taskController.text,
      "date": startDate,
      "description":desController.text,
    };
    var res = await Api().authData(data, '/task/add-task');
    var body = json.decode(res.body);

    print('addedtask${body}');
    worker_id=body['details']['worker_id'];
    print("worker_id${worker_id}");
    localStorage = await SharedPreferences.getInstance();
    localStorage.setString('_id', worker_id.toString());
    if(body['success']==true) {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => Depart_Task(),
        ), //MaterialpageRoute
      );
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
          title: Text("Add Task"),
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
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text("Add Task",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent
                    ),),
                ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: SizedBox(
              width: double.maxFinite,
              child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)) ,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                  hint: Text('Workers'),
                  value: dropDownValue,
                  items: worker
                      .map((type) => DropdownMenuItem<String>(
                    value: type['_id'].toString(),
                    child: Text(
                      type['name'].toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                  ))
                      .toList(),
                  onChanged: (type) {
                    setState(() {
                      dropDownValue = type;
                    });
                  }),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextFormField(
              controller: taskController,
              // controller: _vehicleNoController,
              style: TextStyle(color: Colors.black, fontSize: 18),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Task'),
            ),
          ),   Row(

            children: [

        Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Container(
            height: 45,
            width:150 ,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black26)
            ),
            child: Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text('${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38
                ),),
            ),
          ),
        ),
        const SizedBox(height: 20.0,),
        ElevatedButton(
          onPressed: () => _selectDate(context),
          child: const Text('Start date'),
        ),]
                ),

                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
                    controller: desController,
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
                       setState(() {
                         _addTask();
                       });
                      },
                      child: Text(
                        "ADD",
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
