import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/manage_complaints.dart';
import 'package:public_issue_management/COMPANY/Workers/manage_workers.dart';
import 'package:public_issue_management/COMPANY/tender_manage.dart';
import 'package:public_issue_management/COMPANY/view_task.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
         elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child:  InkWell(
            onTap: () {
              if(title=='TenderManage'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TenderManage(),
                ));
              }else if(title=='ManageWorkers'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageWorkers(),
                ));
              }else if(title=='ManageComplaints'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageComplaint(),
                ));
              }else if(title=='ViewTask'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Viewtask(),
                ));
              }else{
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TenderManage(),));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black,
                )),
                SizedBox(height: 20.0),
                 Center(
                  child:  Text(title,
                      style:
                           TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complaint Management"),
       /// elevation: .1,
        backgroundColor: Colors.lightBlueAccent,),
       body: Column(
         children: [ 
          SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text( "Company Dashboard",
              style:TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
                color:Colors.lightBlueAccent
              ),),
            ), SizedBox(
              height: 40,
            ),
           GridView.count(
            shrinkWrap: true,
             crossAxisCount: 2,
             padding: EdgeInsets.all(3.0),
             children: <Widget>[
               makeDashboardItem("TenderManage", Icons.document_scanner),
               makeDashboardItem("ManageWorkers", Icons.groups),
               makeDashboardItem("ManageComplaints", Icons.edit_calendar_rounded),
               makeDashboardItem("ViewTask", Icons.task),
             ],
           ),
         ],
       ),
    );
  }
}