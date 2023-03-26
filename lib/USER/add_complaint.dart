import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_storage_path/flutter_storage_path.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:public_issue_management/USER/view_complaint.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Complaint extends StatefulWidget {
  @override
  _ComplaintState createState() => _ComplaintState();
}
class _ComplaintState extends State<Complaint> {


  TextEditingController _compcontroller = TextEditingController();
  TextEditingController _descontroller = TextEditingController();
  TextEditingController _locontroller = TextEditingController();
  bool _isLoading = false;
   late final _filename;
  late SharedPreferences prefs;
  late String login_id,depart_id;

  List department = [];
  String? selectdepart;
  var dropDownValue;
  /// Variables
  File? imageFile;
  late String storedImage;

  final _formKey = GlobalKey<FormState>();
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
  Future getAllDepartments()async{
    var res = await Api().getData('/signup/view-all-dipartments');
    var body = json.decode(res.body);

    setState(() {
     department=body['data'];
     depart_id = body['data'][0]['_id'];

    });
  }
  Future<void> getLogin() async {
    prefs = await SharedPreferences.getInstance();
    login_id = (prefs.getString('login_id') ?? '');
    print('login_id_complaint ${login_id}');
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllDepartments();
    getLogin();
  }
  void addComplaint()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "login_id":login_id.replaceAll('"', '') ,
      "department_id":depart_id,
      "complaint_title": _compcontroller.text,
      "description": _descontroller.text,
      "image":_filename,
      "location": _locontroller.text,
    };
    print(data);
    // if(data.image){
    //   var res = await Api().authData(data.image, '/upload');
    //
    // }
    var res = await Api().authData(data, '/complaint/add-complaint');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      addComplaintImage();
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
      Navigator.push(
        this.context, //add this so it uses the context of the class
        MaterialPageRoute(
          builder: (context) => View_Comp(),
        ), //MaterialpageRoute
      );
   //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));

    }
    else
    {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

    }
  }
  void addComplaintImage()async{
    setState(() {
      _isLoading = true;
    });

    var data = {
      "login_id":login_id.replaceAll('"', ''),
      "image":imageFile,

    };
    var res = await Api().authData(data, '/complaint/upload-image');
    var body = json.decode(res.body);

    if(body['success']==true)
    {
      print(body);
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

   //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));

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
    return Scaffold(
        bottomNavigationBar: ElevatedButton(
            style: ElevatedButton.styleFrom
              (backgroundColor: Colors.lightBlueAccent),
            onPressed: () {
              addComplaint();
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
            child: Form(
              key:_formKey,
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
                    controller: _compcontroller,
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
                    controller: _descontroller,
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
                    controller: _locontroller,
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
                        hint: Text('Department'),
                        value: dropDownValue,
                        items: department
                            .map((type) => DropdownMenuItem<String>(
                          value: type['_id'].toString(),
                          child: Text(
                            type['department_name'].toString(),
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


                ],
              ),
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
      setState(()  {

        imageFile = File(pickedFile.path);
         _filename = basename(imageFile!.path);
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);


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
        _filename = basename(imageFile!.path).toString();
        final _nameWithoutExtension = basenameWithoutExtension(imageFile!.path);
        final _extenion = extension(imageFile!.path);

      });
    }
  }
}