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
  late String name;
  late String address;
  late String phn;
  late String email;
  late String username;
  late SharedPreferences prefs;
  @override
  Future<void> initState() async {
    super.initState();
    prefs = await SharedPreferences.getInstance();
    loginid = (prefs.getString('login_id') ?? '');
    print('login_idupdate ${loginid}');
    _viewPro();
  }
  Future<void> _viewPro() async {
  var res = await Api().getData('/signup/user-profile/' + loginid.replaceAll('"', ''));
     var body = json.decode(res.body);
     print(body);
     setState(() {
       name = body['data']['name'];
       print(name);
       address = body['data']['address'];
       phn = body['data']['phone'];
       email = body['data']['email'];
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
      "loginid": "641999eba522f06826048eea"
    };
    print(data);
    var res = await Api().authData(data, '/signup/update-profile');
    var body = json.decode(res.body);

    if (body['success'] == true) {
      print(body);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => User_board(),
      ));
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
            child: Column(
              children: [
                Column(
                  children: [
                    TextInputField(
                      controller: nameController,
                      icon: Icons.person,
                      hint: name,
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controller: emailController,
                      icon: Icons.email,
                      hint: email,
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    /* TextInputField(
                      controller: usernameController,
                      icon: Icons.person_outlined,
                      hint: 'User',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
*/
                    TextInputField(
                      controller: addressController,
                      icon: Icons.location_history_outlined,
                      hint: address,
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      controller: phnController,
                      icon: Icons.phone,
                      hint: phn,
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
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
                            _update();
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
        )
      ],
    );
  }
}
