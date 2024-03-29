
import 'package:flutter/material.dart';
import 'package:public_issue_management/USER/user_pro.dart';
import 'package:public_issue_management/USER/view_complaint.dart';
import 'package:public_issue_management/Widgets/background.dart';
import 'package:public_issue_management/login.dart';
import 'package:public_issue_management/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late SharedPreferences localStorage;
 late String login_id;
   final myImageAndCaption = [
      ["images/user.png", "Profile"],
      ["images/complaint.png", "Complaint"],
     ["images/complaint.png", "Logout"],
    ];
   Future<void> getLogin() async {
     localStorage = await SharedPreferences.getInstance();
     login_id = (localStorage.getString('login_id') ?? '');
     print('login_iddashboard ${login_id}');
   }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogin();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       appBar: AppBar(  
        title: Text("Complaint Management"),  
        backgroundColor: Colors.transparent,
        /* leading:IconButton(onPressed:(){
           Navigator.of(context).push(MaterialPageRoute(
               builder: (context) => LoginPage(),
           ));
         },
             icon: Icon(Icons.arrow_back)),*/
      ),  
        body: Stack(
          children: [
            BackgroundImage(image: 'images/street.jpg'),
            Column(
              children: [
                 SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text( "USER DASHBOARD",
                  style:TextStyle(
                    fontSize:25,
                    fontWeight:FontWeight.bold,
                    color:kWhite
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(26.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfile(),
                          ));
                        },
                        child: Column(

                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage("images/user.png"),
                            ),
                            SizedBox(height: 15,),
                            Text("Profile",style: TextStyle(
                              color:kWhite,
                              fontSize: 20,
                            )
                              ,),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => View_Comp(),
                            ));
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage("images/complaint.png"),
                              ),
                              SizedBox(height: 15,),
                              Text("Complaint",style: TextStyle(
                                color:kWhite,
                                fontSize: 20,
                              )
                                ,),
                            ],
                          ),
                        ),
                      ), Padding(
                        padding: const EdgeInsets.only(left:30.0),
                        child: GestureDetector(
                          onTap: () {
                            localStorage.setBool('login', true);
                            Navigator.pushReplacement(context,
                                new MaterialPageRoute(builder: (context) => LoginPage()));

                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                child: Icon(Icons.logout),
                              ),
                              SizedBox(height: 15,),
                              Text("Logout",style: TextStyle(
                                color:kWhite,
                                fontSize: 20,
                              )
                                ,),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
               /* GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: [
                    ...myImageAndCaption.map(
                      (i) => Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          InkWell(
                           onTap: () {

                        //     _goToPage(category.id);
                           },
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
                ),*/
              ],
            ),
          ],
        ),
      );


  }

}
