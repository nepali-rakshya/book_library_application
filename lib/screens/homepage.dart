import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:book_application/models/user_model.dart';
import 'package:book_application/screens/notedescription.dart';
import 'package:book_application/screens/updateNotes.dart';
import '../libraries.dart';

class HomePage extends StatefulWidget {
  final String? userId;
  final String? noteId;
  const HomePage({Key? key, this.userId, this.noteId}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        loggedInUser = loggedInUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.blue[100],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNotes(userId: loggedInUser.uid),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Book Library", style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23.0,
                                  color: Colors.white),),
        backgroundColor: Colors.blue[200],
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.logout, color: Colors.blue))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bgimg.jpg"),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(loggedInUser.uid)
            .collection('notes')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.blue,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: snapshot.data!.docs.map((document) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return NoteDescription(
                        userId: loggedInUser.uid!,
                        title: document['title'],
                        description: document['description'],
                        createdDate: document['createdDate'],
                        createdTime: document['createdTime'],
                      );
                    })));
                  },
                  child: Card(
                    elevation: 5.0,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                              child: Image.asset(
                                  "assets/images/booklogo.png")),
                          iconColor: Colors.black,
                          title: Text(
                            document['title'],
                            style: const TextStyle(
                                color: Colors.black, fontSize: 30.0),
                          ),
                          subtitle: Text(
                            document['description'],
                            style: TextStyle(
                                fontSize: 20.0, color: Colors.grey[700]),
                          ),
                          isThreeLine: true,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => UpdateNotes(
                                                    userId: loggedInUser.uid,
                                                    noteId: document.id,
                                                    title: document['title'],
                                                    description:
                                                        document['description'],
                                                    createdDate:
                                                        document['createdDate'],
                                                    createdTime:
                                                        document['createdTime'],
                                                  )));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.white,
                                    ),
                                    color: Colors.green,
                                  ),
                                  RaisedButton(
                                    elevation: 3.0,
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(loggedInUser.uid)
                                          .collection('notes')
                                          .doc(document.id)
                                          .delete();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    ),
    );
  }
}
