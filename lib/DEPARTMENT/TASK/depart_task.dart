
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/add_task.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/update_task.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Depart_Task extends StatefulWidget {
  const Depart_Task( {Key? key}) : super(key: key);

  @override
  State<Depart_Task> createState() => _Depart_TaskState();
}

class _Depart_TaskState extends State<Depart_Task> {
  late SharedPreferences localStorage;
  late String department_id;
  late String task_id;
  List _loadedTask = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    _fetchData();
  }

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
    department_id = (localStorage.getString('department_id') ?? '');
    print('dept_id ${department_id}');
    var res = await Api()
        .getData('/task/department-added-task/' + department_id.replaceAll('"', ''));

    if (res.statusCode == 200) {
      var body = json.decode(res.body)['data'];

      setState(()  {
        _loadedTask = body;
        /*  worker_id=int.parse(body['data']['_id']).toString();
        print("worker_id${worker_id}");
       localStorage = await SharedPreferences.getInstance();
        localStorage.setString('_id', worker_id.toString());
*/
      });
    } else {
      setState(() {
        _loadedTask = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text("ViewTask"),
              backgroundColor: Colors.lightBlueAccent,
              leading:IconButton(onPressed:(){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Depart_Board(),
                ));
              },
                  icon: Icon(Icons.arrow_back)),
            ),
            body:SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Container(
                child: Column(
                    children:<Widget> [

                      Padding(
                        padding: const EdgeInsets.only(top:15.0),
                        child: Text("Tasks",style: TextStyle(
                            fontSize:26,
                            fontWeight: FontWeight.bold,
                            color:Colors.lightBlueAccent
                        ),),
                      ),
                      SizedBox(height:20),
                      ListView.builder(
                        shrinkWrap:true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _loadedTask.length,
                        itemBuilder: (context,index){
                          return GestureDetector(
                            onTap: () async {

                              task_id=_loadedTask[index]['_id'];
                              print("task_id ${task_id}");
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => UpdateTask(task_id)));
                            },
                            child: Card(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [
                                          Text(_loadedTask[index]['task_name'],
                                            style:TextStyle(
                                              fontSize: 18,
                                            ) ,),
                                          Text(_loadedTask[index]['date'],
                                            style:TextStyle(
                                              fontSize: 18,
                                            ) ,),
                                          Text(_loadedTask[index]['description'],
                                              style:TextStyle(
                                                fontSize: 18,
                                              )),
                                        ],
                                      ),

                                    /*  ElevatedButton(onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => UpdateTask(),
                                        ));
                                      },
                                          child: Text("Update"))*/
                                    ],

                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ]),

              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DepartAddTask(),
                ));
              },
              tooltip: 'Add Task',
              child: const Icon(Icons.add),
            ),
          ),
    );
  }
}
