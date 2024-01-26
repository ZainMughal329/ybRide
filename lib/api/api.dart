import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

class APis {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
}