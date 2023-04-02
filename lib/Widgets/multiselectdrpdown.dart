
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:public_issue_management/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final Function(List<String>) onSelect;

  MultiSelectDropdown({
    required this.options,
    required this.selectedOptions,
    required this.onSelect,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  List<String> _selectedOptions = [];
  bool _isLoading = false;
  late SharedPreferences localStorage;
  late String  company_id;

  @override
  void initState() {
    super.initState();
    _selectedOptions = widget.selectedOptions;
   // getAllWorkers();
  }
/*  Future getAllWorkers()async{
    localStorage = await SharedPreferences.getInstance();
    company_id = (localStorage.getString('company_id') ?? '');
    print('login_workerdash ${company_id}');
    var res = await Api().getData('/worker/view-all-workers/' + company_id.replaceAll('"', ''));
    var body = json.decode(res.body);

    setState(() {
      _selectedOptions=body['data'];

      print('workers ${_selectedOptions}');

    });
  }*/
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)) ,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5)),
      ),
      hint: Text('Workers'),
      isExpanded: true,
      value: _selectedOptions,
      items: widget.options
          .map((option) => DropdownMenuItem(
        value: option,
        child: Row(
          children: [
            Checkbox(
              value: _selectedOptions.contains(option),
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _selectedOptions.add(option);
                  } else {
                    _selectedOptions.remove(option);
                  }
                  widget.onSelect(_selectedOptions);
                });
              },
            ),
            SizedBox(width: 10),
            Text(option),
          ],
        ),
      ))
          .toList(), onChanged: (Object? value) {  },
    );
  }
}