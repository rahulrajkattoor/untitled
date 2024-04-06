import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCbVrHtUFMJ4qzgeOWhyVWxyklj3NSaz2Q",
        appId: "1:243447360191:android:2f1d402008e8d8f2efb40a",
        messagingSenderId: '',
        projectId:"mockstore-a975a")
  );
}

class store extends StatefulWidget{
  @override
  State<store> createState() => _storeState();
}

class _storeState extends State<store> {
  var name_controller=TextEditingController();
  var email_controller=TextEditingController();
  late CollectionReference _userCollection;
  @override
  void initState() {
    _userCollection=FirebaseFirestore.instance.collection("USER");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("firestore cluud"),),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: name_controller,
              decoration: InputDecoration(
                labelText: "name",border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 15,),
            TextField(controller: email_controller,
            decoration: InputDecoration(labelText: "email",border: OutlineInputBorder()),),
            SizedBox(height: 15,),
            ElevatedButton(onPressed: (){
              addUser();
            }, child:Text("Add user")),
            SizedBox(height: 15,),
            StreamBuilder(stream: getUser(), builder: (context,snapshot){
              if(snapshot.hasError){
                return Text("Error${snapshot.error}");
              }if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              final users=snapshot.data!.docs;
              return Expanded(child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context,index){
                    final USER=users[index];
                    final USERId=USER.id;
                    final USERname=USER['name'];
                    final USERemail=USER['email'];
                    return ListTile(
                      title: Text('$USERname',style: TextStyle(fontSize: 20),),
                      subtitle: Text("$USERemail",style: TextStyle(fontSize: 15),),
                      trailing: Wrap(
                        children: [
                          IconButton(onPressed: (){
                            editUser(USERId);
                          }, icon: Icon(Icons.edit)),
                          IconButton(onPressed: (){
                            deleteUser(USERId);
                          }, icon: Icon(Icons.delete))
                        ],
                      ),
                    );

              }));
            })
          ],
        ),
      ),
    );
  }
  Future<void>addUser()async{
    return _userCollection.add({
      'name':name_controller.text,
      'email':email_controller.text
    }).then((value){
      print("user add succesfully");
      name_controller.clear();
      email_controller.clear();
    }).catchError((error){
      print("failed to add user$error");
    });
  }
  Stream<QuerySnapshot>getUser(){
    return _userCollection.snapshots();
  }
  Future<void>updateUser(var id,String newname,String newemail){
    return _userCollection
        .doc(id)
        .update({'name':newname,"email":newemail}).then((value){
          print("user updated succesfully");

    }).catchError((error){
      print("user deletion failed $error");

    });
  }
  Future<void>deleteUser(var id){
    return _userCollection.doc(id).delete().then((value){
      print("user deleted succesfully");
    }).catchError((error){
      print("user deletion failed $error");
    });
  }

  void editUser(var id){
    showDialog(context: context, builder: (context){
      final newname_controller=TextEditingController();
      final newemail_controller=TextEditingController();
      return AlertDialog(
        title: Text("update user"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: newname_controller,
              decoration: InputDecoration(hintText: "Enter name",border: OutlineInputBorder()),
            ),
            SizedBox(height: 15,),
            TextField(
              controller: newemail_controller,
              decoration: InputDecoration(hintText: "Enter email",border: OutlineInputBorder()),
            )

          ],
        ),
        actions: [
          TextButton(onPressed: (){
            updateUser(id,newname_controller.text,newemail_controller.text).then((value){
              Navigator.pop(context);
            });

          }, child:Text("Update"))
        ],
      );
    });
  }
}