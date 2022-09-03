import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateItemPage extends StatefulWidget {
  // final Client client;
  const CreateItemPage({
    Key? key,
    // required this.client,
  }) : super(key: key);

  @override
  State<CreateItemPage> createState() => _CreateItemPageState();
}

class _CreateItemPageState extends State<CreateItemPage> {
  //instantiating the variables
  final TextEditingController machineName = TextEditingController();
  final TextEditingController machineModel = TextEditingController();
  final TextEditingController machineDetails = TextEditingController();

  //function for setting the token
  // setToken(String value) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('token', value);
  // }

  //function for getting the token
  // getToken(String token) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.getString(token);
  // }

//button to post item to the backend
  postItemHandler(
      String machineName, String machineModel, String machineDetails) async {
    var postUrl = Uri.parse('http://10.0.2.2:8000/MainApp/allproduct/');

    var headers = <String, String>{
      'Content-Type': 'multipart/form-data',
      //'Authorization': 'Bearer $token',
    };

    var request = http.MultipartRequest('POST', postUrl)
      ..fields['machineName'] = machineName
      ..fields['machineModel'] = machineModel
      ..fields['machineDetails'] = machineDetails;

    request.headers.addAll(headers);

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = jsonEncode(responsed.body);

    print(responseData);

    if (response.statusCode == 200) {
      print('sent successfully');
    } else if (response.statusCode == 415) {
      print('unsupported media type');
    } else if (response.statusCode == 401) {
      print('unauthorized');
    } else {
      print(responsed.body);
      throw Exception('did not get there, sorry');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
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
              onPressed: () => postItemHandler(
                  machineName.text, machineModel.text, machineDetails.text),
              child: const Text(
                'Post Item',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
