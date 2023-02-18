
import 'package:flutter/material.dart';
import 'package:public_issue_management/USER/Model/complaint_model.dart';

class View_Comp extends StatelessWidget {
  const View_Comp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
    title: 'User Dashboard',
      home:view_complaint()
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

final List<complaint_model>model=List.generate(complaints.length, (index)
 => complaint_model(complaints[index],desc[index],));
//pass data to the data model
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        child: Column(
          children:<Widget> [
               Text("Complaints"),
               ListView.builder(
                 shrinkWrap:true,
            itemCount: complaints.length,
            itemBuilder: (context,index){
              return Card(
            child: ListTile(
              title: Text(model[index].complaints),
              subtitle:Text(model[index].desc), 
              
            ),
              );
            },
            )
        ]),

      ),
       floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), 
    );

  }
}