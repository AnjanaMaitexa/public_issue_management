
import 'package:flutter/material.dart';

class User_board extends StatelessWidget {
  const User_board({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'User Dashboard',
      debugShowCheckedModeBanner: false,
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
   final myImageAndCaption = [
      ["images/user.png", "Profile"],
      ["images/complaint.png", "Complaint"],
    ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(  
        title: Text("Complaint Management"),  
        backgroundColor: Colors.teal,  
      ),  
        body: Column(
          children: [
             SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text( "User Dashboard",
              style:TextStyle(
                fontSize:20,
                fontWeight:FontWeight.bold,
                color:Colors.teal
              ),),
            ), SizedBox(
              height: 40,
            ),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              children: [
                ...myImageAndCaption.map(
                  (i) => Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [GestureDetector(
                       onTap: () {
                            
                          },
                              child: Container(),
                       ),
                      Material(
                        shape: CircleBorder(),
                        elevation: 3.0,
                        child: Image.asset(
                          i.first,
                          fit: BoxFit.fitWidth,
                          height: 100,
                          width: 100,
                        ),
                      ),

                        Expanded(
                        
                        flex: 1,
                    
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(5),
                    child: Text(i.last),
                  ),
                        
                          ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
   
                                    
  }
}  