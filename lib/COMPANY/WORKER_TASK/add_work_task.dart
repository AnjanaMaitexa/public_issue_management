
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/WORKER_TASK/woker_task.dart';
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
  late String login_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  List worker = [];
  String? selectworker;
  var dropDownValue;

  DateTime selectedDate = DateTime.now();

  late String startDate;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        startDate='${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }
 _addWorker(){

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
                      value: dropDownValue,
                      items: worker
                          .map((type) => DropdownMenuItem<String>(
                        value: type['_id'].toString(),
                        child: Text(
                          type['workers_name'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ))
                          .toList(),
                      onChanged: (type) {
                        setState(() {
                          dropDownValue = type;
                        });
                      }),
                ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: taskController,
                      // controller: _vehicleNoController,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5)),
                          hintText: 'Task'),
                    ),   Row(

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
                    ),

            ],
                ),
              ),
            ),
          ),
        ));
  }

}