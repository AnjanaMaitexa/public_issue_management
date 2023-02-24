
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/Workers/Comp_Model/model_worker.dart';
import 'package:public_issue_management/COMPANY/Workers/add_worker.dart';
import 'package:public_issue_management/COMPANY/Workers/update_worker.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';

class ManageWorkers extends StatefulWidget {
  const ManageWorkers({Key? key}) : super(key: key);

  @override
  State<ManageWorkers> createState() => _ManageWorkersState();
}

class _ManageWorkersState extends State<ManageWorkers> {

  static List<int>Workers_id=[1,2,3];
  static List<String>Workers_name=['Name1','Name2','Name3',];

  final List<Workers>model=List.generate(Workers_id.length, (index)
  => Workers(Workers_id[index],Workers_name[index],));
//pass data to the data model


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ManageWorkers"),
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
                  child: Text("Workers",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  shrinkWrap:true,
                  itemCount: Workers_id.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text("Id:" +model[index].Workers_id.toString(),
                                    style:TextStyle(
                                      fontSize: 18,
                                    ) ,),
                                  Text("Name:"+model[index].Workers_name,
                                      style:TextStyle(
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                             Padding(
                               padding: const EdgeInsets.symmetric(horizontal: 20),
                               child: ElevatedButton(onPressed: (){},
                                  child: Text("Remove")),
                             ),
                            SizedBox(width: 8,),
                            ElevatedButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateWorker(),
                              ));
                            },
                                child: Text("Update"))
                            ],

                        ),
                      ),
                    );
                  },
                )
              ]),

        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Addworker(),
            ));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
