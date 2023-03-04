
import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/depart_task.dart';

class UpdateTask extends StatefulWidget {
  const UpdateTask({Key? key}) : super(key: key);

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  final List<String> compTitle = [
    'Water',
    'ElectricLine',
    'StreetLight',
  ];
  String? selectTitle;
  final List<String> compny = [
    'CompanyA',
    'CompanyB',
    'CompanyC',
  ];
  String? selectComp;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Task"),
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
                  child: Text("Update Task",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent
                    ),),
                ),
                const SizedBox(
                  height: 20,
                ), Padding(
                  padding: const EdgeInsets.only(left:40.0,right: 40),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)) ,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        hint: Text('SelectComplaint'),
                        value: selectTitle,
                        items: compTitle
                            .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                        onChanged: (type) {
                          setState(() {
                            selectTitle = type;
                          });
                        }),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(left:40.0,right: 40),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)) ,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        hint: Text('Select Company'),
                        value: selectComp,
                        items: compny
                            .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(
                            type,
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                        onChanged: (type) {
                          setState(() {
                            selectComp = type;
                          });
                        }),
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: TextField(
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
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText: "Status",
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Depart_Task(),));
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
      ),
    );
  }
}