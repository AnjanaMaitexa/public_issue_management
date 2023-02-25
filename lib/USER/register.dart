

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:public_issue_management/login.dart';


class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
  return const MaterialApp(
      home:MyStatefulWidget()
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/back.jpg'),
                      fit: BoxFit.cover ),
                  ),
                  child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text( "REGISTER",
            style:TextStyle(
              fontSize:20,
              fontWeight:FontWeight.bold,
              color:Colors.teal
            ),),
          ),
           SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              decoration: InputDecoration(
                hintText:"Name" ,
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
                hintText:"Address" ,
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
                hintText:"Email" ,
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
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TextField(
              decoration: InputDecoration(
                hintText:"Password" ,
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
                hintText:"Confirm Password" ,
                border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),

            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.teal
              ),
              height: 40,
              //width: 200,
              child: TextButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPage()));
                },
              child: Text(
                "REGISTER",style: TextStyle(fontSize: 18,
                fontWeight:FontWeight.bold,
                color: Colors.white),
              ),

              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child:RichText(
               text: TextSpan(
        text: 'Already have an account?',
        style: TextStyle(color: Colors.black, fontSize: 16),
        children: <TextSpan>[
            TextSpan(text: ' Sign In',
                style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                }
            )
        ]
    ),

              ),
            ),
        ],

      ),
      ),
    );
  }
}