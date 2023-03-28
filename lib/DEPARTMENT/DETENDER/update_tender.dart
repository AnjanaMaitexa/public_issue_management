
import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/DETENDER/tender_manage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateTender extends StatefulWidget {
  const UpdateTender({Key? key}) : super(key: key);

  @override
  State<UpdateTender> createState() => _UpdateTenderState();
}

class _UpdateTenderState extends State<UpdateTender> {
  bool _isLoading = false;
  String name="";
  String address="";
  String phn="";
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
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
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
                          child: Text("${selectedDate.toLocal()}".split(' ')[0],
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
                          child: Text("${selectedEndDate.toLocal()}".split(' ')[0],
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
                  child: TextField(
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
                  child: TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:"Status" ,
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
                          builder: (context) => TenderManage(),));
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
      ),
    );
  }
}
