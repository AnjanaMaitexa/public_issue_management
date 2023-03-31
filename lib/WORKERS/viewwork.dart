import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/WORKERS/viewdetail.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewWorkTask extends StatefulWidget {
  const ViewWorkTask({Key? key}) : super(key: key);

  @override
  State<ViewWorkTask> createState() => _ViewWorkTaskState();
}

class _ViewWorkTaskState extends State<ViewWorkTask> {
  late SharedPreferences localStorage;
  late String login_id;
  late String worker_id;
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
    login_id = (localStorage.getString('login_id') ?? '');
    print('worker_id ${login_id}');
    var res = await Api()
        .getData('/task/worker-view-task/' + login_id.replaceAll('"', ''));
    if (res.statusCode == 200) {
      var body = json.decode(res.body)['data'];
      print(body);
      setState(()  {
        _loadedWorkers = body;
        /*  worker_id=int.parse(body['data']['_id']).toString();
        print("worker_id${worker_id}");
       localStorage = await SharedPreferences.getInstance();
        localStorage.setString('_id', worker_id.toString());
*/
      });
    } else {
      setState(() {
        _loadedWorkers = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
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
            itemCount: _loadedWorkers.length,
            itemBuilder: (context,index){
              return GestureDetector(
                onTap:() async {
                  worker_id=_loadedWorkers[index]['_id'];
                  localStorage = await SharedPreferences.getInstance();
                  localStorage.setString('_id', worker_id.toString());
                  //   print("worker ${_loadedWorkers[index]['_id']}");

                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewDetailTask(),
                  ));
                },
                child: Card(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text(_loadedWorkers[index]['task_name'] ,
                                style:TextStyle(
                                  fontSize: 18,
                                ) ,),
                              Text(_loadedWorkers[index]['description'],
                                  style:TextStyle(
                                    fontSize: 18,
                                  )),
                            ],
                          ),
                          ElevatedButton(onPressed: (){},
                              child: Text("Status")),

                        ],

                      ),
                    ),
                  ),
                ),
              );
            },
          )
    ],
    );
  }
}
