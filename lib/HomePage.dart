import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final db = FirebaseFirestore.instance;
  String task;

  void showdialog(bool isUpdated, DocumentSnapshot ds) {
    GlobalKey<FormState> formkey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: isUpdated ? Text("Update Todo") : Text("Add ToDo"),
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
              onPressed: () {
                if (isUpdated) {
                  db
                      .collection('tasks')
                      .doc(ds.id)
                      .update({'task': task, 'time': DateTime.now()});
                } else {
                  db
                      .collection('tasks')
                      .add({'task': task, 'time': DateTime.now()});
                }
                Navigator.pop(context);
              },
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
        onPressed: () => showdialog(false, null),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection('tasks').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  child: ListTile(
                    title: Text(ds['task']),
                    onTap: () {
                      showdialog(true, ds);
                    },
                    leading: Icon(Icons.description, color: Colors.yellow),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        db.collection('tasks').doc(ds.id).delete();
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    ));
  }
}
