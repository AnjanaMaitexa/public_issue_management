
import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/add_task.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/model_dtask.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/update_task.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';

class Depart_Task extends StatefulWidget {
  const Depart_Task({Key? key}) : super(key: key);

  @override
  State<Depart_Task> createState() => _Depart_TaskState();
}

class _Depart_TaskState extends State<Depart_Task> {
  static List<String>task=["task1","task2","task3"];
  static List<String>details=['des1','des2','de3',];
  static List<String>status=['done','progress','progress',];

  final List<DTask>model=List.generate(task.length, (index)
  => DTask(task[index],details[index],status[index]));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
            body:Container(
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
                      itemCount: task.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Text("Task:" +model[index].task,
                                        style:TextStyle(
                                          fontSize: 18,
                                        ) ,),
                                      Text("Description:"+model[index].details,
                                          style:TextStyle(
                                            fontSize: 18,
                                          )),
                                    ],
                                  ),
                                  ElevatedButton(onPressed: (){},
                                      child: Text("Remove")),
                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => UpdateTask(),
                                    ));
                                  },
                                      child: Text("Update"))
                                ],

                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ]),

            ),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddTask(),
                ));
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ),
    );
  }
}
