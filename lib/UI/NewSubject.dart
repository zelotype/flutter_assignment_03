import 'package:flutter/material.dart';
import 'package:flutter_assignment_03/Firebase.dart';

class NewSubject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewSubjectState();
  }
}

class NewSubjectState extends State<NewSubject> {
  final _formkey = GlobalKey<FormState>();
  final formController = TextEditingController();
  Icon backIcon = new Icon(Icons.arrow_back);

  @override
  Widget build(BuildContext context) {
    void backPressed() {
      setState(() {
        Navigator.pushNamed(context, "/");
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[300],
        title: Text('New Subject'),
        leading: IconButton(icon: backIcon, onPressed: backPressed),
      ),
      body: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: "Subject"),
                controller: formController,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please fill subject';
                  }
                },
              ),
              RaisedButton(
                child: Text("Save"),
                onPressed: () {
                  _formkey.currentState.validate();
                  if(formController.text.length > 0){
                    Firebase.addTask(formController.text.trim());
                    Navigator.pop(context);
                  }
                  formController.text = "";
                },
              )
            ],
          )),
    );
  }
}
