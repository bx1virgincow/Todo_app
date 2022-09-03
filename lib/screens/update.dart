import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/items.dart';

class UpdatePage extends StatefulWidget {
  final Items items;
  const UpdatePage({Key? key, required this.items}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  //controllers
  var machineName;
  var machineModel;
  var machineDetails;

  @override
  void initState() {
    super.initState();
    //declaring the controllers
    machineName = TextEditingController();
    machineModel = TextEditingController();
    machineDetails = TextEditingController();

    //initializing the controllers
    machineName.text = widget.items.machineName;
    machineModel.text = widget.items.machineModel;
    machineDetails.text = widget.items.machineDetails;
  }

  @override
  void dispose() {
    machineName.dispose();
    machineModel.dispose();
    machineDetails.dispose();
    super.dispose();
  }

  //update handler function
  updateHandler(int id) async {
    var updateUrl = Uri.parse('http://10.0.2.2:8000/MainApp/allproduct/$id/');

    var request = http.MultipartRequest('PUT', updateUrl)
      ..fields['machineName'] = machineName.text
      ..fields['machineModel'] = machineModel.text
      ..fields['machineDetails'] = machineDetails.text;

    var response = await request.send();
    print(response);
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Page',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text('Update Item'),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Item name',
                ),
                controller: machineName,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Item model',
                ),
                controller: machineModel,
              ),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Item details',
                ),
                controller: machineDetails,
                maxLines: 5,
              ),
              OutlinedButton(
                onPressed: () => updateHandler(widget.items.id),
                child: const Text(
                  'Update Item',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ));
  }
}
