import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/DEWORKERS/add_worker.dart';
import 'package:public_issue_management/DEPARTMENT/DEWORKERS/update_workers.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageWorkers extends StatefulWidget {
  const ManageWorkers({Key? key}) : super(key: key);

  @override
  State<ManageWorkers> createState() => _ManageWorkersState();
}

class _ManageWorkersState extends State<ManageWorkers> {
  late SharedPreferences localStorage;

  late String worker_id;
  late String department_id;
  late String name;
  late String address;
  late String phn;
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
    department_id = (localStorage.getString('department_id') ?? '');
    print('dept_id ${department_id}');
    var res = await Api()
        .getData('/worker/department-view-all-workers/' + department_id.replaceAll('"', ''));
    if (res.statusCode == 200) {
      var body = json.decode(res.body)['data'];
      print(body);
      setState(()  {
        _loadedWorkers = body;


      });
    } else {
      setState(() {
        _loadedWorkers = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("ManageWorkers"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Depart_Board(),
                ));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Workers",
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightBlueAccent),
              ),
            ),
            SizedBox(height: 20),

            ListView.builder(
              shrinkWrap: true,
              itemCount: _loadedWorkers.length, //snapshot.data!.length,
              itemBuilder: (context, index) {
                worker_id=_loadedWorkers[index]['_id'];
                return GestureDetector(
                  onTap: () async {

                    worker_id=_loadedWorkers[index]['_id'];
                    print("woree ${worker_id}");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdateWorker(worker_id,)));
                  },
                  child: Card(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Text(_loadedWorkers[index]['_id'],
                                    style: TextStyle(
                                      fontSize: 1,color: Colors.white,
                                    )),
                                Text(_loadedWorkers[index]['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                Text(_loadedWorkers[index]['address'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                Text(_loadedWorkers[index]['phone'],
                                    style: TextStyle(
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

            )

          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Addworker(),
            ));
          },
          tooltip: 'Add Worker',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
