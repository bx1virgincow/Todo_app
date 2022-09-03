import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:tutorial/models/items.dart';
import 'package:tutorial/screens/createItem.dart';
import 'package:tutorial/screens/update.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //api link
  //String retrieveApi = 'http://10.0.2.2:8000/MainApp/allproduct/';

  //creating the http to fetch data from the backend
  //Client client = http.Client();

  //List
  List<Items> items = [];

  @override
  void initState() {
    _retrieveItems();
    super.initState();
  }

  //retrieve items
  _retrieveItems() async {
    items = [];

    final response = json.decode(
        (await http.get(Uri.parse('http://10.0.2.2:8000/MainApp/allproduct/')))
            .body);

    for (var element in response) {
      items.add(Items.fromMap(element));
    }
    // var response = json.decode((await http.get(Uri.parse(retrieveApi))).body);
    // for (var element in response) {
    //   items.add(Items.fromJson(element));
    // }
    setState(() {});
    print(response);
  }

  //method to delete note
  void _deleteItem(int id) {
    String deleteItemApi = 'http://10.0.2.2:8000/MainApp/allproduct/$id/';
    //client.delete(Uri.parse(deleteItemApi));
    var response = http.delete(Uri.parse(deleteItemApi));
    print(response);
    _retrieveItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "MyTile",
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retrieveItems();
        },
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // leading: Image.network(
              //   items[index].machineImage,
              //   width: 60,
              //   height: 60,
              // ),
              title: Text(items[index].machineName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(items[index].machineModel),
                  Text(items[index].machineDetails),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) => UpdatePage(
                      items: items[index],
                    ),
                  ),
                );
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteItem(items[index].id);
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => CreateItemPage(
              // client: client,
              ),
        )),
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }
}
