import 'dart:convert';

import 'package:apimaximo_app/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Maximo Customers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Future<List<Customer>> getAllCustomers() async {
    List<Customer> listCustomer = [];

    final response = await get(
        'http://192.168.1.105:9081/maxrest/rest/os/SM31?_compact=1&_format=json&_lid=sdugas&_lpwd=123456',
        headers: {"Content-type": "application/json"});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      for (Map i in data['QuerySM31Response']['SM31Set']['PLUSPCUSTOMER']) {
        listCustomer.add(Customer.fromJson(i));
      }
    }
    return listCustomer;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getAllCustomers(),
        builder: (context, snapshot) {
          List<Customer> listData = snapshot.data;
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (BuildContext context, int index) => Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listData[index].CUSTOMER,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(listData[index].NAME),
                    ],
                  ),
                ),
              ),
              itemCount: listData.length,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getAllCustomers,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
