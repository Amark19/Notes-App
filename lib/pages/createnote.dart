import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class Createnote extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection("Notes");
  DateTime now = DateTime.now();
  List months = [
    'jan',
    'feb',
    'mar',
    'apr',
    'may',
    'jun',
    'jul',
    'aug',
    'sep',
    'oct',
    'nov',
    'dec'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          FlatButton(
              onPressed: () {
                ref.add({
                  'note_title': titleController.text,
                  'note_desc': descController.text,
                  'Date created': '${now.hour}:${now.minute},${now.day} ${months[now.month - 1]} ${now.year}',
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text("Save"))
        ]),
        body: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(children: [
              Container(
                  decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.title,
                          color: Colors.amber[300],
                        ),
                        border: InputBorder.none,
                        hintText: "Title"),
                    textInputAction: TextInputAction.next,
                  )),
              SizedBox(height: 10),
              Expanded(
                flex: 1,
                child: Container(
                    decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: TextField(
                      controller: descController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.description,
                            color: Colors.amber[300],
                          ),
                          border: InputBorder.none,
                          hintText: "Description"),
                      maxLines: null,
                      // expands: true,
                      textInputAction: TextInputAction.done,
                    )),
              ),
            ])));
  }
}
