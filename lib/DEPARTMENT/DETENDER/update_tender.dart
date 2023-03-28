
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/tender_manage.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateTender extends StatefulWidget {
  const UpdateTender({Key? key}) : super(key: key);

  @override
  State<UpdateTender> createState() => _UpdateTenderState();
}

class _UpdateTenderState extends State<UpdateTender> {
  bool _isLoading = false;
  String name="";
  String description="";
  String sstartDate="";
  String eendDate="";
  late SharedPreferences localStorage;
  late String tender_id;

  TextEditingController nameTController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController desController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  late String startDate;
  late String endDate;

  List company = [];
  String? selectcom;
  var dropDownValue;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        String formattedDate=picked.toIso8601String();
        startController.text=formattedDate.substring(0, 10);

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
        String endformatted=picked.toIso8601String();
        endController.text=endformatted.substring(0, 10);

        endDate='${selectedEndDate.day}/${selectedEndDate.month}/${selectedEndDate.year}';
      });
    }
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _viewTender();
  }

  Future<void> _viewTender() async {
    localStorage = await SharedPreferences.getInstance();
    tender_id = (localStorage.getString('_id') ?? '');
    print('tend ${tender_id}');
    var res = await Api().getData('/tender/view-single-tender/' + tender_id);
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['tender_name'];
      description = body['data']['description'];
      sstartDate = body['data']['job_start_date'];
      eendDate = body['data']['job_end_date'];
      nameTController.text=name;
      desController.text=description;
      startController.text=sstartDate;
      endController.text=eendDate;


    });
  }

  _update() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "tender_name": nameTController.text,
      "job_start_date":startController.text,
      "job_end_date": endController.text,
      "description": desController.text

    };
    print(data);
    var res =
    await Api().authData(data, '/tender/update-single-tender/' + tender_id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TenderManage()));
    } else {
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
          title: Text("Update Tenders"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => TenderManage(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:SingleChildScrollView(
          child: Container(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text( "Update Tenders",
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
                    controller: nameTController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:"TenderName" ,
                      border:
                      OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),

                  ),
                ),
                SizedBox(
                  height: 10,
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
                          child: TextField(
                            controller:startController,
                              decoration: InputDecoration(
                                hintText:"StartDate" ,
                                  )
                            ,),
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
                          child:  TextField(
                            controller:endController,
                            decoration: InputDecoration(
                              hintText:"EndDate" ,
                                 )
                            ,),
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
                  child: TextField(
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
                          _update();
                        });
                      /*  Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TenderManage(),));
                   */   },
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
      ),
    );
  }
}
