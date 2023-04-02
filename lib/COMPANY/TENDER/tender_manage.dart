
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
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
  String approve="1";
  String reject="0";
  String status="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    prefs = await SharedPreferences.getInstance();
    
    company_id = (prefs.getString('company_id') ?? '');
    print('login_company ${company_id}');

    var res = await Api()
        .getData('/tender/company-view-tender/' +company_id.replaceAll('"', '') );
    //  print(res);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      //   print(items);
      setState(() {
        _loadedTender = items;

        print('itemsloaded${_loadedTender}');

      });
    } else {
      setState(() {
        _loadedTender = [];
        Fluttertoast.showToast(
          msg:"Currently there is no tenders available",
          backgroundColor: Colors.grey,
        );
      });
    }
  }

  _acceptTender(String tender_id) async{
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "tender_id": tender_id,
    };
    print(data);
    var res =
    await Api().authData(data, '/tender/accept-tender/' + tender_id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

  /*    Navigator.push(
          context, MaterialPageRoute(builder: (context) => TenderManage()));
 */   } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  _rejectTender(String tender_id) async{
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "_id":tender_id
      /*  "tender_name": nameTController.text,
      "job_start_date":startController.text,
      "job_end_date": endController.text,
      "description": desController.text
*/
    };
    print(data);
    var res =
    await Api().authData(data, '/tender/reject-tender/' + tender_id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      /*    Navigator.push(
          context, MaterialPageRoute(builder: (context) => TenderManage()));
 */   } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
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
              builder: (context) => Dashboard(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child: Column(
              children:<Widget> [

                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text("Tenders",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  shrinkWrap:true,
                  itemCount: _loadedTender.length,

                  itemBuilder: (context,index){
                    return GestureDetector(
                      onTap:() async {
                        tender_id=_loadedTender[index]['_id'];
                        status=_loadedTender[index]['status'];
                        prefs = await SharedPreferences.getInstance();
                        prefs.setString('_id', tender_id.toString());
                        //   print("worker ${_loadedWorkers[index]['_id']}");
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Wrap(
                              children: [
                                SizedBox(height: 50,),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(onPressed: (){
                                        setState(() {

                                          _acceptTender(tender_id);
                                        });
                                      },
                                          child: Text("Accept")),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(onPressed: (){
                                        setState(() {
                                          _rejectTender(tender_id);
                                        });

                                      },
                                          child:Text("Reject")),
                                    )
                                  ],
                                )
                              ],
                            );
                          },
                        );

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
                            /*  ElevatedButton(onPressed: (){
                                setState(() {

                                  _acceptTender(tender_id);
                                });
                              },
                                  child: Text("Accept")),
                              ElevatedButton(onPressed: (){
                               setState(() {
                                 _rejectTender(tender_id);
                               });

                              },
                                  child: Text("Reject"))*/
                            ],

                          ),
                        ),
                      ),
                    );
                  },
                )
              ]),

        ),
      /*  floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddTender(),
            ));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),*/
      ),
    );
  }
}
