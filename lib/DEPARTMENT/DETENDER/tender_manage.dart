
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/add_tender.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/tender_model.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/update_tender.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenderManage extends StatefulWidget {
  const TenderManage({Key? key}) : super(key: key);

  @override
  State<TenderManage> createState() => _TenderManageState();
}

class _TenderManageState extends State<TenderManage> {


  late SharedPreferences prefs;
  late String company_id;
  late String depart_id;
  late String tender_id;
   String name="";
   String start="";
   String end="";
   String desc="";
  List _loadedTender = [];
  bool isLoading = false;
/*
  Future<void> getLogin() async {
    prefs = await SharedPreferences.getInstance();
    depart_id = (prefs.getString('department_id') ?? '');
    print('login_department ${depart_id}');

    _fetchData();
  }
*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    prefs = await SharedPreferences.getInstance();
    depart_id = (prefs.getString('department_id') ?? '');
    print('login_department ${depart_id}');

    var res = await Api()
        .getData('/tender/department-added-tender/' +depart_id.replaceAll('"', '') );
  //  print(res);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
   //   print(items);
      setState(() {
        _loadedTender = items;
        print(_loadedTender);

      });
    } else {
      setState(() {
        _loadedTender = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          title: Text("ManageTender"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Depart_Board(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
                    shrinkWrap:true,
                    itemCount:  _loadedTender.length,
                    itemBuilder: (context,index){
                      return GestureDetector(
                        onTap: ()async {
                          tender_id=_loadedTender[index]['_id'];
                          prefs = await SharedPreferences.getInstance();
                          prefs.setString('_id', tender_id.toString());
                             print("tender ${tender_id}");

                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateTender(),
                          ));
                        },
                        child: Card(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [
                                      Text(_loadedTender[index]['tender_name'],
                                        style:TextStyle(
                                          fontSize: 18,
                                        ) ,),
                                      Text("StartDate:"+ _loadedTender[index]['job_start_date'],
                                        style:TextStyle(
                                          fontSize: 18,
                                        ) ,),
                                      Text("EndDate:"+_loadedTender[index]['job_end_date'],
                                          style:TextStyle(
                                            fontSize: 18,
                                          )),
                                      Text("Description:"+_loadedTender[index]['description'],
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
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTender(),
            ));
          },
          tooltip: 'Add Tender',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
