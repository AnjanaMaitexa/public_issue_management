/*
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:public_issue_management/USER/imagee.dart';
import 'package:public_issue_management/USER/view_complaint.dart';
import 'package:image_picker/image_picker.dart';

class Complaint extends StatefulWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  final List<String> depart = [
    'Health',
    'Education',
    'Labour',
    'Railways',
    'Transport',
    'Communications',
    'Commerce',
    'Industries',
    'Others',
  ];
  String? selectdepart;
  File? imageFile;

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    //  maxWidth: 1800,
    //  maxHeight: 1800,
    );
    if (pickedFile != null) {
       imageFile = File(pickedFile.path);
    }
  }
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    //  maxWidth: 1800,
     // maxHeight: 1800,
    );
    if (pickedFile != null) {
       imageFile = File(pickedFile.path);
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:const Text("Choose from"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: const Text("Gallery"),
                    onTap: () {
                      _getFromGallery();
                      Navigator.pop(context);
                    //  _openGallery(context);
                    },
                  ),
                  SizedBox(height:10),
                  const Padding(padding: EdgeInsets.all(0.0)),
                  GestureDetector(
                    child: const Text("Camera"),
                    onTap: () {
                      _getFromCamera();

                      Navigator.pop(context);
                   //   _openCamera(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
  _decideImageView() {
    if (imageFile == null) {
      return
        Image.asset("images/back.jpg", width: 200, height: 200,);
      */
/* const Text("Image", style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Colors.teal));*//*

    }
    else {
      Image.file(imageFile!, width: 200, height: 200,);
     // print("image printed");
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom
                (backgroundColor: Colors.lightBlueAccent),
              onPressed: () {
                Navigator.of(context).push( MaterialPageRoute(builder: (context)=>View_Comp()));
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
            title: Text("Complaint Management"),
            backgroundColor: Colors.lightBlueAccent,
            leading: IconButton(onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => View_Comp(),
              ));
            },
                icon: Icon(Icons.arrow_back)),
          ),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Text(
                    'Register Your Complaint',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.lightBlueAccent),
                  ),
                  SizedBox(height: 25,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Complaint',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Complaint'),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    // controller: _vehicleNoController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Description'),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Location',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black38),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    // controller: _vehicleNoController,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5)),
                        hintText: 'Location'),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Department',
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
                    hint: Text('Drop down'),
                    value: selectdepart,
                    items: depart
                        .map((type) => DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: TextStyle(color: Colors.black),
                      ),
                    ))
                        .toList(),
                    onChanged: (type) {
                      setState(() {
                        selectdepart = type;
                      });
                    }),
              ),
                  SizedBox(height: 20),

                  ListTile(
                    leading:
                    _decideImageView(),

                    title: Container(

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                         ),
                      height:50,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                           onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPage()));
                            // MyPage();
                        //  _showChoiceDialog(context);
                          },

                          child: const Text("Upload Image")),
                    ),
                  ),
                ],
              )
              ,),
          ),
        ),
    );
  }
}*/
