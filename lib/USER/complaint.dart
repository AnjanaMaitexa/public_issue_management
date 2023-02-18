import 'package:flutter/material.dart';

class Complaint extends StatefulWidget {
  const Complaint({Key? key}) : super(key: key);

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Complaint Management"),
          backgroundColor: Colors.lightBlueAccent,
          // actions: [IconButton(onPressed: (){}, icon: Icon.back)],
        ),
        body: Column(children: [
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              'Register Your Complaint',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
            leading: Text(
              'Complaint Title',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Complaint",
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const ListTile(
            leading: Text(
              ' Description',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Complaint Description",
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          ListTile(
          //  leading:
          //  _decideImageView(),
            // Text(
            //   ' Image',
            //   style: TextStyle(
            //       fontSize: 17,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.teal),
            // ),
            title: TextButton(
                onPressed: () {
                //  _showChoiceDialog(context);
                },

                child: const Text("Upload Image")),
          ),
          const SizedBox(
            height: 30,
          ),
          const ListTile(
            leading: Text(
              ' Location',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            title: TextField(
              decoration: InputDecoration(
                hintText: "ComplaintLocation",
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const ListTile(
            leading: Text(
              ' DepartmentName',
              maxLines: 1,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlueAccent),
            ),
            title: TextField(
              decoration: InputDecoration(
                hintText: "Complaint Description",
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ),
        ]));
  }
}

