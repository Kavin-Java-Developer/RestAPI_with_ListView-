import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //variable and method declare
  List data = [];
  Future<void> fetchdata() async {
    final res = await http.get(Uri.parse("https://reqres.in/api/users?page=1"));
    print(res.statusCode);
    print('data is ready...');
    print(res.body.toString());
    setState(() {
      data = jsonDecode(res.body)['data'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Rest API'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  data += [
                    {
                      "id": 7,
                      "email": "kavinrohit@gmail.com",
                      "first_name": "Kavin",
                      "avatar": "https://reqres.in/img/faces/3-image.jpg"
                    }
                  ];
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
              )),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                data[index]['first_name'],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                data[index]['email'],
                style: TextStyle(fontSize: 17, fontStyle: FontStyle.italic),
              ),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data[index]['avatar']),
                radius: 30,
              ),
              trailing: IconButton(
                onPressed: () {
                  print("Data Deleted Successfully...");
                  setState(() {
                    data.removeWhere(
                        (entry) => (entry)['id'] == data[index]['id']);
                  });
                },
                icon: Icon(Icons.delete),
              ),
            );
          }),
    );
  }
}
