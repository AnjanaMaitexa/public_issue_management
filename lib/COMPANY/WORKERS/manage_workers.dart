import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/COMPANY/Workers/add_worker.dart';
import 'package:public_issue_management/COMPANY/Workers/update_worker.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageWorkers extends StatefulWidget {
  const ManageWorkers({Key? key}) : super(key: key);

  @override
  State<ManageWorkers> createState() => _ManageWorkersState();
}

class _ManageWorkersState extends State<ManageWorkers> {
  late SharedPreferences localStorage;
  late String company_id;
  late String worker_id;
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
    company_id = (localStorage.getString('company_id') ?? '');
    print('login_workerdash ${company_id}');
    var res = await Api()
        .getData('/worker/view-all-workers/' + company_id.replaceAll('"', ''));
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      print(items);
      setState(() {
        _loadedWorkers = items;

      });
    } else {
      setState(() {
        _loadedWorkers = [];
        Fluttertoast.showToast(
          msg:"Currently there is no Workers available",
          backgroundColor: Colors.grey,
        );
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
                  builder: (context) => Dashboard(),
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

                return GestureDetector(
                  onTap:() async {
                    worker_id=_loadedWorkers[index]['_id'];
                    localStorage = await SharedPreferences.getInstance();
                    localStorage.setString('_id', worker_id.toString());
                 //   print("worker ${_loadedWorkers[index]['_id']}");

                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateWorker(),
                    ));
                  },
                  child: Card(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment:CrossAxisAlignment.start ,
                            children: [

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
          tooltip: 'Add Workers',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
