
import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPLAINTS/depart_complaint.dart';
import 'package:public_issue_management/DEPARTMENT/DEWORKERS/manage_workers.dart';
import 'package:public_issue_management/DEPARTMENT/TASK/depart_task.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/tender_manage.dart';
import 'package:public_issue_management/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences localStorage;
late String login_id,depart_id;
Future<void> getLogin() async {
  localStorage = await SharedPreferences.getInstance();
  login_id = (localStorage.getString('login_id') ?? '');
  depart_id = (localStorage.getString('department_id') ?? '');
  print('login_depart ${login_id}');
  print('login_newdepart ${depart_id}');
}
@override
void initState() {
  // TODO: implement initState
  super.initState();
  getLogin();
}
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
              }else if(title=='Tenders'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TenderManage(),
                ));
              }else if(title=='ManageWorkers'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageWorkers(),
                ));
              } else if(title=='AssignTask'){
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
        title: Text("Department Management"),
        /// elevation: .1,
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(onPressed:(){
            localStorage.setBool('login', true);
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => LoginPage()));

          },
              icon: Icon(Icons.logout)),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "Deparatment Dashboard",
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
                  makeDashboardItem("Tenders", Icons.document_scanner),
                  makeDashboardItem("ManageWorkers", Icons.task),
                  makeDashboardItem("AssignTask", Icons.task),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}