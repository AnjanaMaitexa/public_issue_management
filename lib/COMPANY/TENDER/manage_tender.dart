
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ManageTender extends StatefulWidget {
  const ManageTender({Key? key}) : super(key: key);

  @override
  State<ManageTender> createState() => _ManageTenderState();
}

class _ManageTenderState extends State<ManageTender> {

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
  String reply='';
  bool isExpanded = false;
  bool _isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    /*   prefs = await SharedPreferences.getInstance();

  company_id = (prefs.getString('company_id') ?? '');
    print('login_company ${company_id}');
*/
    var res = await Api()
        .getData('/tender/company-view-tender/'  );
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
  bool isReplying = false;
  TextEditingController replyController = TextEditingController();

  @override
  void dispose() {
    replyController.dispose();
    super.dispose();
  }

  void toggleReply() {
    setState(() {
      isReplying = !isReplying;
    });
  }

  void sendReply() async{
     reply = replyController.text;
    prefs = await SharedPreferences.getInstance();
    company_id = (prefs.getString('company_id') ?? '');
    print('login_workerdash ${company_id}');
    setState(() {
      _isLoading = true;
    });

    var data = {
      "company_id":company_id.replaceAll('"', ''),
      "tender_id": tender_id.toString(),
      "amount": reply,

    };
    print(data);
    var res = await Api().authData(data,'/tender/add-tender-reply');
    var body = json.decode(res.body);

    print(body);
    if(body['success']==true)
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
    replyController.clear();
    toggleReply();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          child: Column(
              children:<Widget> [

                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text("Tenders",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _loadedTender.length,
                  itemBuilder: (context, index) {
                    tender_id=_loadedTender[index]['_id'];
                    print("tendid${tender_id}");
                     name=_loadedTender[index]['tender_name'];
                     start=_loadedTender[index]['job_start_date'];
                    end=_loadedTender[index]['job_end_date'];
                    desc=_loadedTender[index]['description'];

                    return Column(
                      children: [
                        ListTile(
                          title: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [

                              Text(_loadedTender[index]['tender_name'],
                                style:TextStyle(
                                  fontSize: 20,fontWeight: FontWeight.bold
                                ) ,),
                              Text("StartDate:"+ _loadedTender[index]['job_start_date'],
                                style:TextStyle(
                                  fontSize: 18,color: Colors.black
                                ) ,),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              Text("EndDate:"+_loadedTender[index]['job_end_date'],
                                  style:TextStyle(
                                    fontSize: 18,color: Colors.black
                                  )),
                              Text("Description:"+_loadedTender[index]['description'],
                                  style:TextStyle(
                                    fontSize: 18,color: Colors.black
                                  )),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.reply,color: Colors.black),
                            onPressed: toggleReply,
                          ),
                        ),
                        if (isReplying)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: replyController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your tender amount...',
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.send),
                                  onPressed: sendReply,
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  },
                )
              ]),

        ),
      ),
    );
  }
}


