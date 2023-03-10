
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/comp_dashboard.dart';
import 'package:public_issue_management/COMPANY/taskmodel.dart';

class Viewtask extends StatefulWidget {
  const Viewtask({Key? key}) : super(key: key);

  @override
  State<Viewtask> createState() => _ViewtaskState();
}

class _ViewtaskState extends State<Viewtask> {

  final TextEditingController _reply = TextEditingController();
  static List<String>task=["task1","task2","task3"];
  static List<String>details=['descriptipn1','descriptipn2','descriptipn3',];
  static List<String>status=['done','progress','progress',];

  final List<Task>model=List.generate(task.length, (index)
  => Task(task[index],details[index],status[index]));
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ViewTask"),
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
                  child: Text("Tasks",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  shrinkWrap:true,
                  itemCount: task.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: [
                                  Text("Task:" +model[index].task,
                                    style:TextStyle(
                                      fontSize: 18,
                                    ) ,),
                                  Text("Description:"+model[index].details,
                                      style:TextStyle(
                                        fontSize: 18,
                                      )),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: ElevatedButton(onPressed: (){
                                  showModalBottomSheet(
                                      isScrollControlled: true,
                                      context: context,
                                      builder: (BuildContext ctx) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              left: 20,
                                              right: 20,
                                              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              TextField(
                                                controller: _reply,
                                                decoration: const InputDecoration(labelText: 'Reply'),
                                              ),

                                              const SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => Viewtask(),
                                                  ));
                                                  },
                                                child: const Text('Reply'),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                                },
                                    child: Text("Reply")),
                              ),

                            ],

                          ),
                        ),
                      ),
                    );
                  },
                )
              ]),

        ),

      ), );
  }

}
