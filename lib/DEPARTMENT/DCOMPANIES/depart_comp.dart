
import 'package:flutter/material.dart';
import 'package:public_issue_management/DEPARTMENT/DCOMPANIES/model_company.dart';
import 'package:public_issue_management/DEPARTMENT/dep_dashboard.dart';

class Company_depart extends StatefulWidget {
  const Company_depart({Key? key}) : super(key: key);

  @override
  State<Company_depart> createState() => _Company_departState();
}

class _Company_departState extends State<Company_depart> {

  static List<String>name=["company1","company2","company3"];
  static List<String>add=['descriptipn1','descriptipn2','descriptipn3',];
  static List<String>email=['a@gmail.com','a@gmail.com','a@gmail.com',];
  static List<String>phone=['9909098787','87909098787','9909098787',];

  final List<Model_Company>model=List.generate(name.length, (index)
  => Model_Company(name[index],add[index],email[index],phone[index]));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("View Companies"),
          backgroundColor: Colors.lightBlueAccent,
          leading:IconButton(onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Depart_Board(),
            ));
          },
              icon: Icon(Icons.arrow_back)),
        ),
        body:Container(
          child: Column(
              children:<Widget> [

                Padding(
                  padding: const EdgeInsets.only(top:15.0),
                  child: Text("Companies",style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color:Colors.lightBlueAccent
                  ),),
                ),
                SizedBox(height:20),
                ListView.builder(
                  shrinkWrap:true,
                  itemCount: name.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            Text(model[index].name,
                              style:TextStyle(
                                fontSize: 18,
                              ) ,),
                            Text(model[index].address,
                                style:TextStyle(
                                  fontSize: 18,
                                )),
                            Text(model[index].email,
                                style:TextStyle(
                                  fontSize: 18,
                                )),
                            Text(model[index].phone,
                                style:TextStyle(
                                  fontSize: 18,
                                )),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ]),

        ),

      ),
    );
  }
}
