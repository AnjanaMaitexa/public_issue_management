
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/Workers/manage_workers.dart';

class UpdateWorker extends StatefulWidget {
  const UpdateWorker({Key? key}) : super(key: key);

  @override
  State<UpdateWorker> createState() => _UpdateWorkerState();
}

class _UpdateWorkerState extends State<UpdateWorker> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Workers"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ManageWorkers(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text( "Update Workers",
                  style:TextStyle(
                      fontSize:20,
                      fontWeight:FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText:"Workers Name" ,
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),

                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  maxLines: 2,
                  decoration: InputDecoration(
                    hintText:"Address" ,
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),

                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText:"Phone" ,
                    border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  ),

                ),
              ),


              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.lightBlueAccent),
                  height:50,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ManageWorkers(),));
                    },
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
