import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/COMPLAINTS/manage_complaints.dart';
import 'package:public_issue_management/COMPANY/WORKER_TASK/woker_task.dart';
import 'package:public_issue_management/COMPANY/Workers/manage_workers.dart';
import 'package:public_issue_management/COMPANY/TENDER/tender_manage.dart';
import 'package:public_issue_management/COMPANY/view_task.dart';
import 'package:public_issue_management/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences localStorage;
  late String login_id;
  late String company_id;
  Future<void> getLogin() async {
    localStorage = await SharedPreferences.getInstance();
    login_id = (localStorage.getString('login_id') ?? '');
    company_id = (localStorage.getString('company_id') ?? '');
    print('companys_id ${company_id}');
    print('companys_loginid ${login_id}');
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
              if(title=='TenderManage'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TenderManage(),
                ));
              }else if(title=='ManageWorkers'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageWorkers(),
                ));
              }else if(title=='Complaints'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageComplaint(),
                ));
              } else if(title=='AssignTask') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WorkerTask(),
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
        leading:IconButton(onPressed:(){
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Dashboard(),
          ));
        },
            icon: Icon(Icons.arrow_back)),
       actions: [
        IconButton(onPressed:(){
          localStorage.setBool('login', true);
          Navigator.pushReplacement(context,
              new MaterialPageRoute(builder: (context) => LoginPage()));

        },
          icon: Icon(Icons.logout)),
       ],
       /// elevation: .1,
        backgroundColor: Colors.lightBlueAccent,),
       body: SingleChildScrollView(
         child: Column(
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
                 makeDashboardItem("Complaints", Icons.edit_calendar_rounded),
                 makeDashboardItem("AssignTask", Icons.add_task),
               //  makeDashboardItem("Logout", Icons.logout),
               ],
             ),
           ],
         ),
       ),
    );
  }
}