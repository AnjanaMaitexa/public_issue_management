

import 'package:flutter/material.dart';
import 'package:public_issue_management/login.dart';

class Dep_Reg extends StatelessWidget {
  const Dep_Reg({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyStatefulWidget()
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
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
                    .of(context)
                    .size
                    .width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/back.jpg'),
                      fit: BoxFit.cover ),
                  ),
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
              const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text( "REGISTER",
              style:TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
                color:Colors.teal
              ),),
            ),
             const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText:"DepartmentName" ,
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
                maxLines: 2,
                decoration: InputDecoration(
                  hintText:"Description" ,
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
                  hintText:"Username" ,
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
                    
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
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
              child:TextButton(
                  onPressed: (){
                    
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage(),));
                  },
                child: Text(
                  "Already have an account?Sign Ip!",style: TextStyle(fontSize: 16,
                  color: Colors.teal),
                ),
              
                ),
              ),
          ],
        
        ),
      ),
   
    );
  }
  }