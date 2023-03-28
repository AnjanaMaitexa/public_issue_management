import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:public_issue_management/DEPARTMENT/DEWORKERS/manage_workers.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateWorker extends StatefulWidget {
  const UpdateWorker({Key? key}) : super(key: key);

  @override
  State<UpdateWorker> createState() => _UpdateWorkerState();
}

class _UpdateWorkerState extends State<UpdateWorker> {
  bool _isLoading = false;
  String name="";
  String address="";
  String phn="";
  late SharedPreferences localStorage;
  late String worker_id;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
/*  Future<void> getLogin() async {
    localStorage = await SharedPreferences.getInstance();
    worker_id = (localStorage.getString('_id') ?? '');
    print('worker_id ${worker_id}');
  }*/
  final _formKey = GlobalKey<FormState>();
  @override
  initState() {
    // TODO: implement initState
    super.initState();

    _viewWorker();
  }

  Future<void> _viewWorker() async {
    localStorage = await SharedPreferences.getInstance();
    worker_id = (localStorage.getString('_id') ?? '');
    print('worker_id ${worker_id}');
    var res = await Api().getData('/worker/view-single-worker/' + worker_id);
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      // print(name);
      address = body['data']['address'];
      phn = body['data']['phone'];
      nameController.text=name;
      addressController.text=address;
      phnController.text=phn;

    });
  }

  _update() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "name": nameController.text,
      "address": addressController.text,
      "phone": phnController.text,
      "_id": worker_id
    };
    print(data);
    var res =
    await Api().authData(data, '/worker/update-single-worker/' + worker_id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ManageWorkers()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  _delete() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {"_id": worker_id};
    print(data);
    var res =
    await Api().deleteData( '/worker/delete-single-worker/' + worker_id);
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );


      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ManageWorkers()));
      print(body['message']);
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Update Workers"),
          backgroundColor: Colors.lightBlueAccent,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ManageWorkers(),
                ));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Container(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "Update Workers",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                buildTextField("Name", name, nameController),
                SizedBox(
                  height: 10,
                ),
                buildTextField("Address", address, addressController),
                SizedBox(
                  height: 10,
                ),
                buildTextField("Phone", phn, phnController),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.lightBlueAccent),
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _update();
                              });
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.lightBlueAccent),
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                _delete();
                              });
                            },
                            child: Text(
                              "DELETE",
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //  hintText: placeholder,
          // hintText:address ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}
