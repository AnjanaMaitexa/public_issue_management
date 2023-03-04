import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:public_issue_management/USER/user_dashboard.dart';
import 'package:public_issue_management/Widgets/background.dart';
import 'package:public_issue_management/Widgets/password-input.dart';
import 'package:public_issue_management/Widgets/text-field-input.dart';
import 'package:public_issue_management/utils.dart';

class EditProfile extends StatelessWidget {
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
                      icon: Icons.person,
                      hint: 'Name',
                      inputType: TextInputType.name,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: Icons.email,
                      hint: 'Email',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon: Icons.lock,
                      hint: 'Password',
                      inputAction: TextInputAction.next,
                    ),
                    PasswordInput(
                      icon:Icons.lock,
                      hint: 'Confirm Password',
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: Icons.location_history_outlined,
                      hint: 'Address',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: Icons.phone,
                      hint: 'Phone no.',
                      inputType: TextInputType.number,
                      inputAction: TextInputAction.next,
                    ),
                    TextInputField(
                      icon: Icons.location_on_outlined,
                      hint: 'Location',
                      inputType: TextInputType.text,
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
                height:50,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => User_board(),));
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
