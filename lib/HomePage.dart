import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void showdialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add ToDo"),
          content: Form(
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Task",
              ),
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

  final db = FirebaseFirestore.instance;
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
