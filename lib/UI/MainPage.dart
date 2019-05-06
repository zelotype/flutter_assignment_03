import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_assignment_03/Firebase.dart';

class main_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return main_pageState();
  }
}

class main_pageState extends State<main_page> {
  int _state = 0;
  Icon addIcon = new Icon(Icons.add);
  Icon delIcon = new Icon(Icons.delete);

  @override
  Widget build(BuildContext context) {
    Future AddPressed() async {
      setState(() {
        Navigator.pushNamed(context, "/newsubject");
      });
    }

    final List button = <Widget>[
      IconButton(icon: addIcon, onPressed: AddPressed),
      IconButton(
          icon: delIcon,
          onPressed: () async {
            Firebase.deleteAllTask();
          })
    ];

    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.pinkAccent[200]
      ),
        home: DefaultTabController(
          length: 2,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.pink[300],
                title: Text('Todo'),
                actions: <Widget>[_state == 0 ? button[0] : button[1]],
              ),
              bottomNavigationBar: BottomNavigationBar(
                fixedColor: Colors.pink[300],
                currentIndex: _state,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.assignment), title: Text("Task")),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.done_all), title: Text("Complete")),
                ],
                onTap: (index) {
                  setState(() {
                    _state = index;
                  });
                },
              ),
              body: _state == 0
                  ? Container(
                child: StreamBuilder(
                    stream: Firestore.instance.collection('todo').where('done', isEqualTo: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                      return snapshot.data.documents.length == 0 ?
                      Center(child: Text('No data found..'))
                          :
                      ListView(
                          children: snapshot.data.documents.map((DocumentSnapshot document) {
                        return CheckboxListTile(
                          title: Text(document['title']),
                          value: document['done'],
                          onChanged: (bool value) {
                            Firebase.updateTask(document.documentID, value);
                          },
                        );
                      }).toList(),
                      );
                    })
              )
                  : Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('todo').where('done', isEqualTo: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return snapshot.data.documents.length == 0 ?
                    Center(child: Text('No data found..'))
                        :
                    ListView(
                      children: snapshot.data.documents.map((DocumentSnapshot document) {
                        return CheckboxListTile(
                          activeColor: Colors.deepPurpleAccent[200],
                          title: Text(document['title']),
                          value: document['done'],
                          onChanged: (bool value) {
                            Firebase.updateTask(document.documentID, value);
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              )),
        ));
  }
}
