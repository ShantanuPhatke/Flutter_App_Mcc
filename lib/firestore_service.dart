import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_app_mcc/entry.dart';

class FirestoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  //Create
  Future<void> setEntry(Entry entry) {
    return _db.collection("entries").doc(entry.entryId).set(entry.toMap());
  }
}
