
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/tender_manage.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTender extends StatefulWidget {
  const AddTender({Key? key}) : super(key: key);

  @override
  State<AddTender> createState() => _AddTenderState();
}

class _AddTenderState extends State<AddTender> {

  TextEditingController nameTController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController desController = TextEditingController();
  bool _isLoading = false;
  late SharedPreferences prefs;
  late String company_id,depart_id;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late String startDate;
  late String endDate;

  final _formKey = GlobalKey<FormState>();
  List company = [];
  String? selectedId;
  var dropDownValue;
  Future<void> getLogin() async {
    prefs = await SharedPreferences.getInstance();
    depart_id = (prefs.getString('department_id') ?? '');

  }

  Future getAllCompany()async{
    var res = await Api().getData('/signup/view-all-companies');
    var body = json.decode(res.body);

    setState(() {
      company=body['data'];

      print('compans ${company}');

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCompany();
    getLogin();
  }
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
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedEndDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;

         endDate='${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}';
      });
    }
  }

  void addTender()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "company_id":selectedId ,
      "department_id":depart_id.replaceAll('"', '') ,
      "tender_name": nameTController.text,
      "job_start_date": startDate,
      "job_end_date":endDate,
      "description": desController.text,
    };
    print(data);
    var res = await Api().authData(data, '/tender/add-tender');
    var body = json.decode(res.body);
    print(body);
    if(body['success']==true)
    {

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => TenderManage(),
        ), //MaterialpageRoute
      );

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
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Tenders"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TenderManage(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child:Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text( "Add Tenders",
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
                    child: TextFormField(
                      controller: nameTController,
                      decoration: InputDecoration(
                        hintText:"TenderName" ,
                        border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                      ),

                    ),
                  ),
                  Row(

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
                               child: Text('${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
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
                  Row(

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
                            child: Text('${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black38
                              ),),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0,),
                      ElevatedButton(
                        onPressed: () => _selectEndDate(context),
                        child: const Text('End date'),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TextFormField(
                      controller: desController,
                      decoration: InputDecoration(
                        hintText:"Description" ,
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
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)) ,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                        hint: Text('Company'),
                        value: selectedId,
                        items: company
                            .map((type) => DropdownMenuItem<String>(
                          value: type['_id'],
                          child: Text(
                            type['company_name'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ))
                            .toList(),
                        onChanged: (type) {
                          setState(() {
                            selectedId = type;
                          });
                        }),
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
                        setState(() {
                          addTender();
                        });   },
                        child: Text(
                          "SUBMIT",
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
        ),
      ),
    );
  }
}
