

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(home: Homepage(),));
}

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var name_controller = TextEditingController();
  var phone_controller = TextEditingController();
  Map<String, String> dataToSave = {};

  CollectionReference collectionRef =
  FirebaseFirestore.instance.collection('user');

  @override
  void initState() {
    super.initState();
    // Add this to execute Firestore operation after the state is initialized
    // collectionRef.add(dataToSave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.location_on_sharp, color: Colors.white,),
        title: Text("Nilambur", style: TextStyle(color: Colors.white),),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "search by a name",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 5),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.sort, color: Colors.white,),
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Users Lists",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context, // Pass context directly
            builder: (BuildContext context) {
              return Container(
                width: 500,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, top: 30),
                          child: Text(
                            "Add A New User",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 80, left: 150),
                          child: CircleAvatar(
                            child: Icon(Icons.person, color: Colors.blue,),
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 150),
                          child: Text("Name"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 170,
                            left: 20,
                            right: 20,
                          ),
                          child: TextField(
                            controller: name_controller,
                            decoration: InputDecoration(
                              hintText: "enter your name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20, top: 240),
                          child: Text("Phone number"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 270,
                            left: 20,
                            right: 20,
                          ),
                          child: TextField(
                            controller: phone_controller,
                            decoration: InputDecoration(
                              hintText: "enter your Phone number",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 160, top: 350),
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Cancel"),
                              ),
                              SizedBox(width: 10,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  dataToSave = {
                                    'Name': name_controller.text,
                                    'phone number': phone_controller.text
                                  };
                                  collectionRef.add(dataToSave);
                                },
                                child: Text("Save"),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 100, left: 180),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
