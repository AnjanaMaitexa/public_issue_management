
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/TENDER/add_tender.dart';
import 'package:public_issue_management/COMPANY/TENDER/tender_model.dart';
import 'package:public_issue_management/COMPANY/TENDER/update_tender.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';

class TenderManage extends StatefulWidget {
  const TenderManage({Key? key}) : super(key: key);

  @override
  State<TenderManage> createState() => _TenderManageState();
}

class _TenderManageState extends State<TenderManage> {
  static List<String>start=['1-2-2022','1-2-2022','1-2-2022'];
  static List<String>end=['2-2-2023','2-2-2023','2-2-2023',];
  static List<String>desc=['desc1','dec2','desc3',];
  static List<String>status=['desc1','dec2','desc3',];

  final List<TenderModel>model=List.generate(start.length, (index)
  => TenderModel(start[index],end[index],desc[index],status[index]));
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(

        appBar: AppBar(
          title: Text("ManageTender"),
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
                  child: Text("Tenders",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  shrinkWrap:true,
                  itemCount: status.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text("StartDate:" +model[index].start,
                                    style:TextStyle(
                                      fontSize: 18,
                                    ) ,),
                                  Text("EndDate:"+model[index].end,
                                      style:TextStyle(
                                        fontSize: 18,
                                      )),
                                  Text("Status:"+model[index].status,
                                      style:TextStyle(
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                            ),
                            ElevatedButton(onPressed: (){},
                                child: Text("Remove")),
                            ElevatedButton(onPressed: (){
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UpdateTender(),
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
              builder: (context) => AddTender(),
            ));
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
