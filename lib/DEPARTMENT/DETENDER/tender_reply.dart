import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TenderReply extends StatefulWidget {
  const TenderReply({Key? key}) : super(key: key);

  @override
  State<TenderReply> createState() => _TenderReplyState();
}

class _TenderReplyState extends State<TenderReply> {
  late SharedPreferences prefs;
  late String company_id;
  late String depart_id;
  late String tender_id;
  late String tender_reply_id;
  String name = "";
  String start = "";
  String end = "";
  String desc = "";
  List _loadedTender = [];
  bool isLoading = false;

  String cname="";
  String cmail="";
  String cphn="";
  String camount="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
    _fetchLowCost();
  }

  _fetchData() async {
    prefs = await SharedPreferences.getInstance();
    depart_id = (prefs.getString('department_id') ?? '');
    print('login_department ${depart_id}');

    var res = await Api()
        .getData('/tender/view-tender-reply/' + depart_id.replaceAll('"', ''));
    print(res);
    if (res.statusCode == 400) {
      var items = json.decode(res.body)['data'];
      print(items);
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
  _fetchLowCost() async {
    prefs = await SharedPreferences.getInstance();
    depart_id = (prefs.getString('department_id') ?? '');
    print('login_department ${depart_id}');

    var res = await Api()
        .getData('/tender/view-low-tender-amount/' + depart_id.replaceAll('"', ''));

    if (res.statusCode == 400) {
      var body = json.decode(res.body);

      setState(() {
        tender_reply_id=body['data']['_id'];
        cname = body['data']['company_name'];
        print("rply id${tender_reply_id}");
        cmail = body['data']['company_email'];
        cphn = body['data']['company_phone'];
        camount = body['data']['tender_reply_amount'];

      });
    } else {
      setState(() {
        _loadedTender = [];
      });
    }
  }

  _acceptTender() async{

    prefs = await SharedPreferences.getInstance();
    tender_id = (prefs.getString('_id') ?? '');
    setState(() {
      var _isLoading = true;
    });

    var res =
    await Api().getData('/tender/accept-low-cost-tender/' +tender_id+'/'+tender_reply_id );
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
          Navigator.push(
          context, MaterialPageRoute(builder: (context) => Depart_Board()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TenderReply"),
        backgroundColor: Colors.lightBlueAccent,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Depart_Board(),
              ));
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _loadedTender.length,
          itemBuilder: (context, index) {
            tender_id= _loadedTender[index]['_id'];
            return InkWell(
              onTap: () async {},
              child: Card(
                child: Container(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _loadedTender[index]['tender_name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "CompanyName : " +
                                  _loadedTender[index]['company_name'],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "CompanyPhone : " +
                                  _loadedTender[index]['company_phone'],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "CompanyEmail : " +
                                  _loadedTender[index]['company_email'],
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                                "Amount Rs:" +
                                    _loadedTender[index]['tender_reply_amount'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
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
      bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(cname,  style: TextStyle(
                              fontSize: 18,
                            ),),
                            Text("Email : "+cmail,  style: TextStyle(
                              fontSize: 18,
                            ),),
                            Text("Phn : "+cphn,  style: TextStyle(
                              fontSize: 18,
                            ),),
                            Text("Amount : "+camount,  style: TextStyle(
                              fontSize: 18,
                            ),),
                            ElevatedButton(
                              child: const Text('Accept'),
                              onPressed: (){
                                _acceptTender();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Text("Show low cost "),
          )),
    );
  }
}
