import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

Future<void> uploadImage(File imageFile, String imageName) async {
  try {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(imageName);
    UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask;
    print('Image uploaded to Firebase Storage');
  } catch (e) {
    print('Error uploading image: $e');
  }
}
