
import 'package:flutter/material.dart';
import 'package:public_issue_management/COMPANY/TENDER/tender_manage.dart';

class UpdateTender extends StatefulWidget {
  const UpdateTender({Key? key}) : super(key: key);

  @override
  State<UpdateTender> createState() => _UpdateTenderState();
}

class _UpdateTenderState extends State<UpdateTender> {

  DateTime selectedDate = DateTime.now();

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
        body:Container(
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
    );
  }
}
