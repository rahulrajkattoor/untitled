import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'contacts.dart';

class AddUser extends StatefulWidget {
  final Function(List<Contact>) onAddUser;

  AddUser({required this.onAddUser});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String imageUrl='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add User"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CircleAvatar(child: IconButton(onPressed: (){




            },icon: Icon(Icons.camera_alt),),radius: 30,),
            SizedBox(height: 10,),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Name",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Phone",
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text.trim();
                String contact = phoneController.text.trim();
                if (name.isNotEmpty && contact.isNotEmpty) {
                  // Create a Contact object with the provided data
                  Contact newContact = Contact(name: name, contact: contact);
                  // Pass the Contact object back to the HomePage
                  widget.onAddUser([newContact]);
                  // Clear the text fields after adding the user
                  nameController.clear();
                  phoneController.clear();
                  Navigator.of(context).pop();
                }
              },
              child: Text("ADD"),
            ),
          ],
        ),
      ),
    );
  }
}
