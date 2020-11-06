import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  String task;

  void showdialog() {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add ToDo"),
          content: Form(
            key: formkey,
            autovalidate: true,
            child: TextFormField(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Task",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return "Can't be empty";
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                task = value;
              },
            ),
          ),
          actions: <Widget>[
            RaisedButton(
              onPressed: () {},
              child: Text("Add"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showdialog,
        child: Icon(Icons.add),
      ),
    ));
  }
}
