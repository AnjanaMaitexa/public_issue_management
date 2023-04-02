
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/USER/Model/complaint_model.dart';
import 'package:public_issue_management/USER/add_complaint.dart';
import 'package:public_issue_management/USER/complaint.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class View_Comp extends StatefulWidget {
  const View_Comp({super.key});

  @override
  State<View_Comp> createState() => _View_CompState();
}

class _View_CompState extends State<View_Comp> {
  String complaint='';
  String description='';
  String statuss='';
  late SharedPreferences localStorage;

  late String login_id;
  bool isExpanded = false;
  List complaints = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getLogin();
    viewComplaint();
  }

  void viewComplaint()async{
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('login_id') ?? '');

  var res = await Api().getData('/complaint/user-added-complaints/'+login_id.replaceAll('"', ''));
  var body = json.decode(res.body);
  print(body);
  if (res.statusCode == 200) {
      var body = json.decode(res.body)['data'];
      print(body);
      setState(()  {
        complaints = body;


      });
    } else {
      setState(() {
        complaints = [];
        Fluttertoast.showToast(
          msg: "No Complaints yet",
          backgroundColor: Colors.grey,
        );


      });
    }
}
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Complaint Management"),
        backgroundColor: Colors.lightBlueAccent,
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => User_board(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
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
                 shrinkWrap:true,
            itemCount: complaints.length,
            itemBuilder: (context,index){
              return Card(
            child:Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(complaints[index]['complaint_title']),
                        Text(complaints[index]['description']),
                      ],
                    ),

                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children:[
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: isExpanded?Icon(Icons.arrow_drop_up):Icon(Icons.arrow_drop_down),
                      ),
                      Visibility(
                        visible: isExpanded,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: isExpanded ? 50.0 : 0.0,
                          child:  (complaints[index]['reply'] == null) ? Text("No reply available"): Text(complaints[index]['reply']),
                        ),
                      )
                      ],
                    ),
                  )

                ],
              ),
            )


              );
            },
            )
        ]),

      ),
       floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Complaint(),
          ));
        },
        tooltip: 'Add Complaints',
        child: const Icon(Icons.add),
      ), 
    );

  }
}