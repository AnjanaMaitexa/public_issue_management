
import 'package:flutter/material.dart';
import 'package:public_issue_management/WORKERS/viewwork.dart';
import 'package:public_issue_management/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkersDashboard extends StatefulWidget {
  const WorkersDashboard({Key? key}) : super(key: key);

  @override
  State<WorkersDashboard> createState() => _WorkersDashboardState();
}

class _WorkersDashboardState extends State<WorkersDashboard> {
  late SharedPreferences localStorage;
  late String worker_id;
  final myImageAndCaption = [
    ["images/user.png", "Profile"],
    ["images/complaint.png", "Complaint"],
    ["images/complaint.png", "Logout"],
  ];
  Future<void> getLogin() async {
    localStorage = await SharedPreferences.getInstance();
    worker_id = (localStorage.getString('_id') ?? '');
    print('login_worker_idd ${worker_id}');
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
              if(title=='ViewTask'){
                localStorage.setBool('login', true);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ViewWorkTask(),
                ));
              }else if(title=='Logout'){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ));

              }else{
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => WorkersDashboard(),));
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
        title: Text("Workers Dashboard"),
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
                child: Text( "Workers Dashboard",
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
                  makeDashboardItem("ViewTask", Icons.task_rounded),
                  makeDashboardItem("Logout", Icons.logout),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}