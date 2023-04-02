
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/COMPANY/WORKER_TASK/woker_task.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddworkerTask extends StatefulWidget {
  const AddworkerTask({Key? key}) : super(key: key);

  @override
  State<AddworkerTask> createState() => _AddworkerTaskState();
}

class _AddworkerTaskState extends State<AddworkerTask> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late SharedPreferences localStorage;
  late String  company_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  List worker = [];
  List tender = [];
  String? selectworker;
  String? selecttender;
  var dropDownValue;
  List<String> selectedworker = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    getAllWorkers();
    getAllTenders();

  }
  Future getAllWorkers()async{
    localStorage = await SharedPreferences.getInstance();
    company_id = (localStorage.getString('company_id') ?? '');
    print('login_workerdash ${company_id}');
    var res = await Api().getData('/worker/view-all-workers/' + company_id.replaceAll('"', ''));
    var body = json.decode(res.body);

    setState(() {
      worker=body['data'];

      print('workers ${worker}');

    });
  }
  Future getAllTenders()async{
    localStorage = await SharedPreferences.getInstance();
    company_id = (localStorage.getString('company_id') ?? '');
    print('login_workerdash ${company_id}');
    var res = await Api().getData('/tender/company-assign-tender/' +company_id.replaceAll('"', ''));
    var body = json.decode(res.body);

    setState(() {
      tender=body['data'];

      print('tender ${tender}');

    });
  }
 _addWorker()async{
   localStorage = await SharedPreferences.getInstance();
   company_id = (localStorage.getString('company_id') ?? '');
   print('login_workerdash ${company_id}');
   setState(() {
     _isLoading = true;
   });

   var data = {
     "company_id":company_id.replaceAll('"', ''),
     "tender_id": selecttender,
     "worker_id": selectworker,

   };
   print(data);
   var res = await Api().authData(data,'/tender/assign-tender');
   var body = json.decode(res.body);

   print(body);
   if(body['success']==true)
   {
     Fluttertoast.showToast(
       msg: body['message'].toString(),
       backgroundColor: Colors.grey,
     );

     Navigator.push(context, MaterialPageRoute(builder: (context)=>WorkerTask()));

   }
   else
   {
     Fluttertoast.showToast(
       msg: body['message'].toString(),
       backgroundColor: Colors.grey,
     );

   }
 }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom
              (backgroundColor: Colors.lightBlueAccent),
            onPressed: () {
              _addWorker();
              // Navigator.of(context).push( MaterialPageRoute(builder: (context)=>View_Comp()));
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 115, left: 115),
              child: Text(
                'SUBMIT',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )),
        appBar: AppBar(
          title: Text("Manage Workers Task"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => WorkerTask(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key:_formKey,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(

                  children: [

                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Workers',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black38),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)) ,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      hint: Text('Workers'),
                      value: selectworker,
                      items: worker
                          .map((type) => DropdownMenuItem<String>(
                        value: type['_id'].toString(),
                        child: Text(
                          type['name'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                          .toList(),
                      onChanged: (type) {
                        setState(() {
                          selectworker = type;
                        });
                      }),
                ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Tenders',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black38),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.maxFinite,
                      child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)) ,
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          hint: Text('Tenders'),
                          value: selecttender,
                          items: tender
                              .map((type) => DropdownMenuItem<String>(
                            value: type['_id'].toString(),
                            child: Text(
                              type['tender_name'].toString(),
                              style: TextStyle(color: Colors.black),
                            ),
                          ))
                              .toList(),
                          onChanged: (type) {
                            setState(() {
                              selecttender = type;
                            });
                          }),
                    ),
                    SizedBox(height: 10),
               /*     TextFormField(
                      controller: taskController,
                      // controller: _vehicleNoController,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Task'),
                    ),*/
                    SizedBox(height: 10),
                  /*  Row(

                      children: [

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Container(
                            height: 45,
                            width:150 ,
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black26)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Text('${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black38
                                ),),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0,),
                        ElevatedButton(
                          onPressed: () => _selectDate(context),
                          child: const Text('Start date'),
                        ),
                      ],
                    ),*/

            ],
                ),
              ),
            ),
          ),
        ));
  }

}