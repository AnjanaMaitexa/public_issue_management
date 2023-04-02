
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/WORKER_TASK/add_work_task.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerTask extends StatefulWidget {
  const WorkerTask({Key? key}) : super(key: key);

  @override
  State<WorkerTask> createState() => _WorkerTaskState();
}

class _WorkerTaskState extends State<WorkerTask> {
  late SharedPreferences localStorage;
  late String company_id;
  late String worker_id;
  late String task;
  late String workername;

  List _loadedWorkers = [];
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
    company_id = (localStorage.getString('company_id') ?? '');
    print('login_workerdash ${company_id}');
    var res = await Api()
        .getData('/tender/assigned-tender/' + company_id.replaceAll('"', ''));
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loadedWorkers = items;

      });
    } else {
      setState(() {
        _loadedWorkers = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ManageTask"),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Dashboard(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body:   ListView.builder(
            shrinkWrap: true,
            itemCount: _loadedWorkers.length, //snapshot.data!.length,
            itemBuilder: (context, index) {

              return Card(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text("Tender Name:"+_loadedWorkers[index]['tender_name'],
                              style: TextStyle(
                                fontSize: 18,
                              )),
                          Text("Worker Name:"+_loadedWorkers[index]['worker_name'],
                              style: TextStyle(
                                fontSize: 18,
                              )),

                               Text("StartDate:"+ _loadedWorkers[index]['start_date'],
                                        style:TextStyle(
                                          fontSize: 18,
                                        ) ,),
                                      Text("EndDate:"+_loadedWorkers[index]['end_date'],
                                          style:TextStyle(
                                            fontSize: 18,
                                          )),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            },

          ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddworkerTask(),
          ));
        },
        tooltip: 'Add Tssk',
        child: const Icon(Icons.add),
      ),

    );
  }
}
