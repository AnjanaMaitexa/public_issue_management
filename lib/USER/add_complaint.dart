import 'dart:convert';
import 'dart:io';
//import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:public_issue_management/USER/view_complaint.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:io' show File;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';

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
  Placemark? placemark;
  String name = '';
  String street ='';
  String city = '';
  String state = '';
  String zip = '';
  String country = '';
  List department = [];
  var dropDownValue;
  /// Variables
  File? imageFile;
  File? file;
  late String storedImage;
  String _cityName='';

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
    // depart_id = body['data'][0]['_id'];
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

    _getCurrentLocation();
  }
  void addComplaint()async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      "login_id":login_id.replaceAll('"', '') ,
      "department_id":dropDownValue,
      "complaint_title": _compcontroller.text,
      "description": _descontroller.text,
      "image":_filename,
      "location": _cityName,
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
    final uri = Uri.parse('http://192.168.43.28:3000/complaint/upload-image');
    final request = http.MultipartRequest('POST', uri);
    final imageStream = http.ByteStream(imageFile!.openRead());
    final imageLength = await imageFile!.length();

    final multipartFile = http.MultipartFile(
      'file',
      imageStream,
      imageLength,
      filename: _filename,
    );
    request.files.add(multipartFile);

    print("multipart${multipartFile}");
    final response = await request.send();
    if(response.statusCode == 200)
    {

      Fluttertoast.showToast(
        msg:"success",
        backgroundColor: Colors.grey,
      );

      //   Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context)=>View_Comp()));

    }
    else
    {
      Fluttertoast.showToast(
        msg:"Failed",
        backgroundColor: Colors.grey,
      );

    }
   /* var data = {
      "login_id":login_id.replaceAll('"', ''),
      "file":imageFile,
    };
    print("data is${data}");
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

    }*/
  }
  Future<void> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Get city name from latitude and longitude
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
     placemark = placemarks[0];
     name = placemark!.name.toString();
     street = placemark!.street.toString();
     city = placemark!.locality.toString();
     state = placemark!.administrativeArea.toString();
     zip = placemark!.postalCode.toString();
     country = placemark!.country.toString();
    setState(() {
      _cityName = '$name, $street, $city, $state $zip, $country';
      print(_cityName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xF5FFFFFF) ,
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
              autovalidateMode: AutovalidateMode.always,
              child: Column(

                children: [
                  Container(
                   /* decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/bg.jpg')
                      )
                    ),*/
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
                  Container(
                    width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black38,),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(_cityName,

                            style: TextStyle(color: Colors.black, fontSize: 17)),
                      )),

                  SizedBox(height: 10),
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
        print("imageFile:${imageFile}");
        print(_filename);
        print(_nameWithoutExtension);
        print(_extenion);
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