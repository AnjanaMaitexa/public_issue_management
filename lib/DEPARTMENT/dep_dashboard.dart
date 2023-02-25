
import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPANIES/depart_comp.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPLAINTS/depart_complaint.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPLAINTS/depart_complaint.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/depart_task.dart';

class Depart_Board extends StatelessWidget {
  const Depart_Board({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Department Dashboard',
      debugShowCheckedModeBanner: false,
      home:MyStatefulWidget()
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Card makeDashboardItem(String title, IconData icon) {
    return Card(
        elevation: 1.0,
        margin: EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1.0)),
          child:  InkWell(
            onTap: () {
              if(title=='Complaints'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewComplaints(),
                ));
              }else if(title=='Companies'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Company_depart(),
                ));
              }else if(title=='AssignTask'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Depart_Task(),
                ));

              }else{
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Depart_Board(),));
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
              makeDashboardItem("Complaints", Icons.document_scanner_sharp),
              makeDashboardItem("Companies", Icons.factory_rounded),
              makeDashboardItem("AssignTask", Icons.task),
            ],
          ),
        ],
      ),
    );
  }
}