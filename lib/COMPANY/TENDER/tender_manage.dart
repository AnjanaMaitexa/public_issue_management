
import 'package:flutter/material.dart';

class TenderManage extends StatefulWidget {
  const TenderManage({Key? key}) : super(key: key);

  @override
  State<TenderManage> createState() => _TenderManageState();
}

class _TenderManageState extends State<TenderManage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            Text("type1")
          ],
        ),
      ),
    );
  }
}
