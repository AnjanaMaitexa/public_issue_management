import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:public_issue_management/USER/view_complaint.dart';

class Complaint extends StatefulWidget {
  @override
  _ComplaintState createState() => _ComplaintState();
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
  /// Variables
  File? imageFile;
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
  /// Widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(

              children: [
                Container(
                  child: imageFile == null
                      ? Container(
                    child: Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            //    _getFromGallery();
                            _showChoiceDialog(context);
                          },
                          child: Text("Upload Image"),
                        ),
                        Container(
                          height: 40.0,
                        ),

                      ],
                    ),
                  ): Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Image.file(
                          imageFile!,
                          width: 100,
                          height: 100,
                          //  fit: BoxFit.cover,
                        ),
                      ), ElevatedButton(
                        onPressed: () {
                          //    _getFromGallery();
                          _showChoiceDialog(context);
                        },
                        child: Text("Upload Image"),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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


              ],
            ),
          ),
        ));
  }

  /// Get from gallery
  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}