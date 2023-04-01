import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/WORKERS/viewwork.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewDetailTask extends StatefulWidget {
  const ViewDetailTask({Key? key}) : super(key: key);

  @override
  State<ViewDetailTask> createState() => _ViewDetailTaskState();
}

class _ViewDetailTaskState extends State<ViewDetailTask> {

  List _loadedTask = [];
  bool isLoading = false;
  late SharedPreferences localStorage;
  late String worker_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
    worker_id = (localStorage.getString('worker_id') ?? '');
    print('worker_idcompany ${worker_id}');
    var res = await Api()
        .getData('/task/worker-view-task/' + worker_id.replaceAll('"', ''));
    if (res.statusCode == 200) {
      var body = json.decode(res.body)['data'];
      print(body);
      setState(()  {
        _loadedTask = body;
        print("_loadedTask${_loadedTask}");
        /*  worker_id=int.parse(body['data']['_id']).toString();
        print("worker_id${worker_id}");
       localStorage = await SharedPreferences.getInstance();
        localStorage.setString('_id', worker_id.toString());
*/
      });
    } else {
      setState(() {
        _loadedTask = [];
        Fluttertoast.showToast(
          msg:"No added Task",
          backgroundColor: Colors.grey,
        );
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
        body: ListView.builder(
          shrinkWrap:true,
          itemCount:  _loadedTask.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: ()async {
              /*  tender_id=_loadedTender[index]['_id'];
                prefs = await SharedPreferences.getInstance();
                prefs.setString('_id', tender_id.toString());
                print("tender ${tender_id}");

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UpdateTender(),
                ));*/
              },
              child: Card(
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text(_loadedTask[index]['tender_name'],
                              style:TextStyle(
                                fontSize: 18,
                              ) ,),
                            Text("StartDate:"+ _loadedTask[index]['job_start_date'],
                              style:TextStyle(
                                fontSize: 18,
                              ) ,),
                            Text("EndDate:"+_loadedTask[index]['job_end_date'],
                                style:TextStyle(
                                  fontSize: 18,
                                )),

                          ],
                        ),
                      ),

                    ],

                  ),
                ),
              ),
            );
          },
        ),

    ),
    );
  }
}
