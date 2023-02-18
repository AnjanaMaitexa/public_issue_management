
import 'package:flutter/material.dart';

class Depart_Board extends StatelessWidget {
  const Depart_Board({super.key});

  @override
  Widget build(BuildContext context) {
   
    return MaterialApp(
      title: 'Department Dashboard',
      debugShowCheckedModeBanner: false,
      home:MyStatefulWidget()
    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}