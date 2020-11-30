import 'package:flutter/material.dart';
import 'package:flutter_app_mcc/entry.dart';
import 'package:flutter_app_mcc/firestore_service.dart';
import 'package:uuid/uuid.dart';

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final mobileController = TextEditingController();
  final nameController = TextEditingController();
  final messageController = TextEditingController();

  final firestoreService = FirestoreService();
  String _entryId;
  String _mobile;
  String _name;
  String _message;
  var uuid = Uuid();

  saveEntry() {
    if (_entryId == null) {
      var newEntry = Entry(
        entryId: uuid.v1(),
        mobile: _mobile.toString(),
        name: _name,
        message: _message,
      );
      firestoreService.setEntry(newEntry);
    }
  }

  clearContollers() {
    mobileController.clear();
    nameController.clear();
    messageController.clear();
  }

  @override
  void dispose() {
    mobileController.dispose();
    nameController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.deepPurpleAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Feedback",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              child: _buildForm(),
            ),
          )
        ],
      ),
    );
  }

  Form _buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                return null;
              },
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: 'Mobile',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide(
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ),
              onChanged: (String value) => _mobile = value,
              controller: mobileController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Name cannot be empty';
                } else if (value.length < 3) {
                  return 'Name must be at least 3 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Name',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (String value) => _name = value,
              controller: nameController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              obscureText: false,
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Message cannot be empty';
                } else if (value.length < 6) {
                  return 'Message must be at least 6 characters long.';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: 'Message',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              ),
              onChanged: (String value) => _message = value,
              controller: messageController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              color: Colors.deepPurpleAccent,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  debugPrint('All validations passed!!!');
                  saveEntry();
                  clearContollers();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
