
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPLAINTS/model_comp.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api.dart';

class ViewComplaints extends StatefulWidget {
  const ViewComplaints({Key? key}) : super(key: key);

  @override
  State<ViewComplaints> createState() => _ViewComplaintsState();
}

class _ViewComplaintsState extends State<ViewComplaints> {
  late SharedPreferences localStorage;
  late String depart_id;
  late String complaint_id;
  bool _isLoading = false;
  TextEditingController replyController = TextEditingController();
  List _loadedComplaints = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    localStorage = await SharedPreferences.getInstance();
  //  login_id = (localStorage.getString('login_id') ?? '');
    depart_id = (localStorage.getString('department_id') ?? '');
    print('login_depart ${depart_id}');
   // print('login_newdepart ${depart_id}');
    var res = await Api()
        .getData('/complaint/view-all-complaints/'+depart_id.replaceAll('"', ''));
      print(res);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
         print(items);
      setState(() {
        _loadedComplaints = items;
        print(_loadedComplaints);

      });
    } else {
      setState(() {
        _loadedComplaints = [];
      });
    }
  }
  _reply(String complaint_id)async{
      setState(() {
        _isLoading = true;
      });

      var data = {
        "_id":complaint_id,
        "reply": replyController.text,

      };
      print(data);
      var res = await Api().authData(data,'/complaint/reply-complaints/' + complaint_id);
      var body = json.decode(res.body);


      if(body['success']==true)
      {
        print('added reply${body}');
        Fluttertoast.showToast(
          msg: body['message'].toString(),
          backgroundColor: Colors.grey,
        );
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ViewComplaints(),));

      }
      else
      {
        Fluttertoast.showToast(
          msg: body['message'].toString(),
          backgroundColor: Colors.grey,
        );

      }

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        appBar: AppBar(
          title: Text("ViewComplaints"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Depart_Board(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Container(
            child: Column(
                children:<Widget> [

                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Text("Complaints",style: TextStyle(
                        fontSize:26,
                        fontWeight: FontWeight.bold,
                        color:Colors.lightBlueAccent
                    ),),
                  ),
                  SizedBox(height:20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap:true,
                    itemCount:  _loadedComplaints.length,
                    itemBuilder: (context,index){
                      complaint_id=_loadedComplaints[index]['_id'];
                      print('complaint reply id${complaint_id}');
                      return Card(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                             /*   CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  backgroundImage:AssetImage(image[index]) ,),*/
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_loadedComplaints[index]['complaint_title'],
                                      style:TextStyle(
                                        fontSize: 18,
                                      ) ,),
                                    Text(_loadedComplaints[index]['location'],
                                      style:TextStyle(
                                        fontSize: 18,
                                      ) ,),
                                    Text(_loadedComplaints[index]['description'],
                                      style:TextStyle(
                                        fontSize: 18,
                                      ) ,),
                                  ],
                                ),
                                ElevatedButton(onPressed: (){
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Wrap(
                                        children: [
                                          SizedBox(height: 50,),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(50.0),
                                                child: TextFormField(
                                                  decoration: InputDecoration(
                                                    hintText:"Reply" ,
                                                    border:
                                                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                  ),
                                                  controller: replyController,

                                                ),
                                              ),
                                            ),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(30.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Colors.lightBlueAccent),
                                                height:50,
                                                width: MediaQuery.of(context).size.width,
                                                child: TextButton(
                                                  onPressed: () {
                                                    _reply(complaint_id);

                                                  },
                                                  child: Text(
                                                    "REPLY",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                    child: Text("REPLY"))

                              ],

                            ),
                          ),
                        ),
                      );
                    },
                  )
                ]),

          ),
        ),

      ),
    );
  }
}


