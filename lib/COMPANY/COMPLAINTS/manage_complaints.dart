
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/COMPLAINTS/complaint_model.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';

class ManageComplaint extends StatefulWidget {
  const ManageComplaint({Key? key}) : super(key: key);

  @override
  State<ManageComplaint> createState() => _ManageComplaintState();
}

class _ManageComplaintState extends State<ManageComplaint> {

  static List<String>complaint=['complaint1','complaint2','complaint3'];
  static List<String>location=['loc1','loc2','loc3'];
  static List<String>image=['images/back.jpg','images/back.jpg','images/back.jpg',];

  final List<Complaint_model>model=List.generate(complaint.length, (index)
  => Complaint_model(complaint[index],image[index],location[index]));
//pass data to the data model

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("ManageComplaints"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Dashboard(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
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
                  itemCount: complaint.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.lightBlueAccent,
                              backgroundImage:AssetImage(image[index]) ,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(model[index].complaint,
                                  style:TextStyle(
                                    fontSize: 18,
                                  ) ,),
                                Text(model[index].location,
                                  style:TextStyle(
                                    fontSize: 18,
                                  ) ,),
                              ],
                            ),

                         /*   ElevatedButton(onPressed: (){},
                                child: Text("APPROVE")),
                            ElevatedButton(onPressed: (){

                            },
                                child: Text("REJECT"))*/
                          ],

                        ),
                      ),
                    );
                  },
                )
              ]),

        ),

      ),
    );
  }
}

/*:Container(
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
                Expanded(
                  child: ListView.builder(
                    shrinkWrap:true,
                    itemCount: complaint.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            backgroundImage:AssetImage(image[index]) ,),
                          title:  Text(model[index].complaint,
                            style:TextStyle(
                              fontSize: 18,
                            ) ,),
                          trailing: Row(
                            children: [

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(onPressed: (){},
                                    child: Text("Approve")),
                              ),
                              SizedBox(width: 8,),
                              ElevatedButton(onPressed: (){

                              },
                                  child: Text("Reject"))
                            ],

                          ),
                        ),
                      );
                    },
                  ),
                )

              ]),

        ),

      ),
    );
  }
}
*/