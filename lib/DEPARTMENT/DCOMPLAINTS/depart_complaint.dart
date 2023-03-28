
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPLAINTS/model_comp.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';

import '../../api.dart';

class ViewComplaints extends StatefulWidget {
  const ViewComplaints({Key? key}) : super(key: key);

  @override
  State<ViewComplaints> createState() => _ViewComplaintsState();
}

class _ViewComplaintsState extends State<ViewComplaints> {

  List _loadedComplaints = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {

    var res = await Api()
        .getData('/complaint/view-all-complaints' );
    //  print(res);
    if (res.statusCode == 200) {
      var items = json.decode(res.body)['data'];
      //   print(items);
      setState(() {
        _loadedComplaints = items;
        print(_loadedComplaints);

      });
    } else {
      setState(() {
        _loadedComplaints = [];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        appBar: AppBar(
          title: Text("ViewComplaints"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Depart_Board(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:SingleChildScrollView(
          child: Container(
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
                    itemCount:  _loadedComplaints.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                             /*   CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  backgroundImage:AssetImage(image[index]) ,),*/
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_loadedComplaints[index]['complaint_title'],
                                      style:TextStyle(
                                        fontSize: 18,
                                      ) ,),
                                    Text(_loadedComplaints[index]['location'],
                                      style:TextStyle(
                                        fontSize: 18,
                                      ) ,),
                                    Text(_loadedComplaints[index]['description'],
                                      style:TextStyle(
                                        fontSize: 18,
                                      ) ,),
                                  ],
                                ),
                                ElevatedButton(onPressed: (){
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Wrap(
                                        children: [
                                          SizedBox(height: 50,),
                                            Container(
                                              child: Padding(
                                                padding: const EdgeInsets.all(50.0),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                    hintText:"Reply" ,
                                                    border:
                                                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                                                  ),

                                                ),
                                              ),
                                            ),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(30.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(50),
                                                    color: Colors.lightBlueAccent),
                                                height:50,
                                                width: MediaQuery.of(context).size.width,
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => ViewComplaints(),));
                                                  },
                                                  child: Text(
                                                    "REPLY",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                    child: Text("REPLY"))

                              ],

                            ),
                          ),
                        ),
                      );
                    },
                  )
                ]),

          ),
        ),

      ),
    );
  }
}


