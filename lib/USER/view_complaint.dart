
import 'package:flutter/material.dart';
import 'package:public_issue_management/USER/Model/complaint_model.dart';
import 'package:public_issue_management/USER/complaint.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';

class View_Comp extends StatelessWidget {
  const View_Comp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
    title: 'User Dashboard',
       debugShowCheckedModeBanner: false,
      home:view_complaint(),
    );
  }
}
class view_complaint extends StatefulWidget {
  const view_complaint({super.key});

  @override
  State<view_complaint> createState() => _view_complaintState();
}

class _view_complaintState extends State<view_complaint> {

static List<String>complaints=['Water Supply issue','Draianage','Electric Line',];
static List<String>desc=['Water is stopped','Drainage overflow','Broken',];
static List<String>status=['Done','Progress','Done',];

final List<complaint_model>model=List.generate(complaints.length, (index)
 => complaint_model(complaints[index],desc[index],status[index]));
//pass data to the data model
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
            child: ListTile(
              title: Text(model[index].complaints),
              subtitle:Text(model[index].desc),
              trailing:Text(model[index].status)
              
            ),
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
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );

  }
}