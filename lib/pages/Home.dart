import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notesapp/pages/editnote.dart';

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ref = FirebaseFirestore.instance.collection("Notes");
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CALNOTES', style: TextStyle(fontSize: 20, color: Colors.amber[300])), backgroundColor: Colors.transparent, centerTitle: true, elevation: 0, automaticallyImplyLeading: false),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.amber[300],
        onPressed: () {
          Navigator.pushNamed(context, "/createnote");
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
          //streambuilder is basically a subscriber who builds widget whenever it gets data
          stream: ref.snapshots(), //of streamcontroller type where stream is a output of it
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              //snapshot is nothing our data
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                      itemBuilder: (context, index) {
                        if (snapshot.data!.docs[index]['note_desc'].length > 75) {
                          text = snapshot.data!.docs[index]['note_desc'].substring(0, 75) + ".....";
                        } else {
                          text = snapshot.data!.docs[index]['note_desc'];
                        }
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => Editnote(doctoedit: snapshot.data!.docs[index])));
                          },
                          child: Container(
                              decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.all(Radius.circular(20))),
                              margin: EdgeInsets.all(10),
                              height: 150,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Text(snapshot.data!.docs[index]['note_title'], style: TextStyle(fontSize: 18.0, color: Colors.amber[200])),
                                    SizedBox(height: 10),
                                    Text(text),
                                  ],
                                ),
                              )),
                        );
                      }));
            }
          }),
    );
  }
}
