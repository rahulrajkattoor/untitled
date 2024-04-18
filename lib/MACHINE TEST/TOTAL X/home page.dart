import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add user.dart';
import 'contacts.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Nilambur",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 40,
                      top: 10,
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        filterContacts(value);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Search by a name",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(Icons.sort),
                    onPressed: () {},
                    color: Colors.white,
                    splashRadius: 24.0,
                    tooltip: 'Sort',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredContacts.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(filteredContacts[index].name),
              subtitle: Text(filteredContacts[index].contact),
              leading  : Image(image: AssetImage("assets/image/Custom-Icon-Design-Pretty-Office-2-Man.256.png"),),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddUser(
                  onAddUser: (newContacts) {
                    setState(() {
                      contacts.addAll(newContacts);
                      filteredContacts = contacts;
                    });
                  },
                )),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
          contact.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
