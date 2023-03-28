import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';
import 'package:public_issue_management/Widgets/background.dart';
import 'package:public_issue_management/Widgets/text-field-input.dart';
import 'package:public_issue_management/api.dart';
import 'package:public_issue_management/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  late String loginid;
  String name = "";
  String address = "";
  String phn = "";
  String email = "";
  String username = "";
  late SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();

  @override
  initState() {
    super.initState();
    _viewPro();
  }

  Future<void> _viewPro() async {
    prefs = await SharedPreferences.getInstance();
    loginid = (prefs.getString('login_id') ?? '');
    print('login_idupdate ${loginid}');
    var res = await Api()
        .getData('/signup/user-profile/' + loginid.replaceAll('"', ''));
    var body = json.decode(res.body);
    print(body);
    setState(() {
      name = body['data']['name'];
      print(name);
      address = body['data']['address'];
      phn = body['data']['phone'];
      email = body['data']['email'];

      nameController.text = name;
      addressController.text = address;
      phnController.text = phn;
      emailController.text = email;
    });
  }

  _update() async {
    setState(() {
      var _isLoading = true;
    });

    var data = {
      "name": nameController.text,
      "address": addressController.text,
      "email": emailController.text,
      "phone": phnController.text,
      "loginid": loginid
    };
    print(data);
    var res = await Api().authData(data, '/signup/update-profile');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => User_board()));
    } else {
      Fluttertoast.showToast(
        msg: body['message'].toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'images/street.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: kWhite,
              ),
            ),
            title: Text(
              'Profile',
              style: kBodyText,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.always,
                  child: Column(
                    children: [
                      Column(
                        children: [
                          buildTextField("Name", name, nameController),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextField("Email", email, emailController),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextField("Address", address, addressController),
                          SizedBox(
                            height: 12,
                          ),
                          buildTextField("Phone", phn, phnController),
                          SizedBox(
                            height: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.lightBlueAccent),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {

                                    _update();
                                  });
                                },
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
                          SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        style: TextStyle(
          color: Colors.white, // set the text color to blue
        ),
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,labelStyle: TextStyle(color: Colors.white38),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          //  hintText: placeholder,
          // hintText:address ,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
