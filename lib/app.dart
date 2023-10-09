import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'user_provider.dart';
import 'package:provider/provider.dart';
import 'search.dart';
import 'logout.dart';







class todo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Form Debugging Test',
      home: MyTabs(),
    );
  }
}







class MyTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        
        appBar: AppBar(

title: Text("→ Contacts Manager"),
          backgroundColor: Colors.green,// title: Text('Tab Bar Example'),
          
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.input),
                text: 'Input',
              ),
              Tab(
                icon: Icon(Icons.contacts),
                text: 'Users',
              ),

               Tab(
                icon: Icon(Icons.search_outlined),
                text: 'Search',
              ),


               Tab(
                icon: Icon(Icons.settings_accessibility_sharp),
                text: 'settings',
              ),



            ],

indicator: BoxDecoration(
              color: Colors.black, // Change this to your desired color
            ),

          ),
        ),
        body: TabBarView(
          children: [
            DebugFormScreen(), 
            FirestoreDemo(), 
              
          UserList(),  
           LogoutScreen()
          
          
          
          ],
        ),
      ),
    );
  }
}






























//--------------fomm tab 1--------------------

class DebugFormScreen extends StatefulWidget {

  const DebugFormScreen({Key? key});

  @override
  DebugFormScreenState createState() => DebugFormScreenState();
}

class DebugFormScreenState extends State<DebugFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  
  
  
  String username = '';
  String password = '';
  








  void submitForm(cid) {
String name=_nameController.text.trim();
    if (_formKey.currentState!.validate()) {
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Successfully saved! $name  $password',
          ),
        ),
      );
   _formKey.currentState!.reset();
    sendDataToFirestore(cid);

    }
  }

   //---------------------------------------


Future<void> sendDataToFirestore(String cid) async {
print("");
String username=_nameController.text;
String number=_passController.text;
String city=_ageController.text;


  try {
    // Reference to the Firestore database
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Collection reference (Replace 'users' with your desired collection name)
    CollectionReference users = firestore.collection('users');

    // Data to be inserted
    Map<String, dynamic> data = {
     'Activeuser':cid,
      'name':username,
      'city': city,
      'number': number
    };

    // Add a new document with a generated ID
    await users.add(data);

    print('Data inserted successfully!');
  } catch (e) {
  print('Error inserting data: $e');
  
  }
}




  @override
  Widget build(BuildContext context) {

final userProvider = Provider.of<UserProvider>(context);
    final Activeuser = userProvider.userId;
    


    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(

              controller: _nameController,
                decoration: const InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),


//------------------------------------------
              const SizedBox(height: 20),
//------------------------------------------              
              
              TextFormField(
                
                controller: _passController,
                decoration: const InputDecoration(labelText: 'Contacts'),
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
              ),


//---------------------------------
const SizedBox(height: 20),
              // Date of Birth Field
 //---------------------------------             



   TextFormField(


   controller: _ageController,
                decoration: const InputDecoration(labelText: 'city'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
              ),
           

//------------------------------------
              const SizedBox(height: 20),
//--------------------------------------


              ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
                onPressed: ()=>{

                  submitForm(userProvider.userId)
                },
                child: const Text('save contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






//-------------------------tab 2 LIST -----------------

class FirestoreDemo extends StatefulWidget {
  @override
  MYFirestoreDemo createState() => MYFirestoreDemo();
}




class MYFirestoreDemo extends State<FirestoreDemo> {




//--------dialog box function------------

void popup(BuildContext context, String name , String body) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Mr. "+name),
          content: Text("Number "+body),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




//----------delete function firebase-----------------



  void onPressed(username) async{
    print(username);
    String Id=username;
   final CollectionReference collection = FirebaseFirestore.instance.collection('users'); // Replace 'your_collection_name' with the actual collection name

  QuerySnapshot querySnapshot = await collection.where('name', isEqualTo: '${Id}').get();



  if (querySnapshot.docs.isNotEmpty) {
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      
      await collection.doc(document.id).delete();
    String name = document.get('name');


      print('Record with ${name} deleted successfully.');
    }
  } else {
    print('No records with name "ali" found.');
  }
  

  }
  

  //---------update function firebase ----------------------
  
  void update (BuildContext context, String username) async {
  
String inputValue = '';

    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark, // Set the brightness to match your dialog content
          scaffoldBackgroundColor: Colors.green, // Set the background color to green
        ),

        
        child: CupertinoAlertDialog(
      
          title: Text("Enter a value:"),
          content: CupertinoTextField(
            onChanged: (value) {
               setState(() {
          
       inputValue=value;
    });



                         },
            placeholder: "Enter a value",
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Cancel"),
              onPressed: () {

                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text("Save"),
              onPressed: ()async {
                // Do something with the inputValue, e.g., save it to a variable.
                Navigator.of(context).pop();
                
                 CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

    // Query for the user document with the specified name
    QuerySnapshot querySnapshot = await usersCollection.where('name', isEqualTo: username).get();

    // Check if a user with the given name exists
    if (querySnapshot.docs.isNotEmpty) {
      // Get the first document (assuming there's only one user with the same name)
      DocumentSnapshot userDoc = querySnapshot.docs.first;

      // Update the desired field, for example, updating the 'age' field
      await usersCollection.doc(userDoc.id).update({'name': inputValue}); // Replace 'age' and '30' with your desired field and value

      print('User updated successfully!');
    } else {
      print('User with name $username not found.');
    }
  
                                      
          
              },
            ),
          ],
        )
        );
        
      },
    );
  }







//----------------------UI



  @override
  Widget build(BuildContext context) {


final userProvider = Provider.of<UserProvider>(context);
    final Activeuser = userProvider.userId;
    



    return Scaffold(
      
      body: StreamBuilder(
    //    stream: FirebaseFirestore.instance.collection('users').snapshots(),
      
      stream: FirebaseFirestore.instance.collection('users').where('Activeuser', isEqualTo: Activeuser).snapshots()
      ,
      
      
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(); // Loading indicator while data is fetched
          }
          final documents = snapshot.data!.docs;
          
          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index].data();
              final title = document['name'];
              final subtitle = document['number'];              


return Container(
width: 20,
decoration: BoxDecoration(
    
    color: Colors.white60, // Background color
    
    border: Border(
      bottom: BorderSide(
        color: Colors.black, // Border color
        width: 0.7,           // Border width
      ),
    )



),

child: ListTile(

leading: Icon(Icons.supervised_user_circle_rounded,color: Colors.green),      
title: Text(title),
 
  subtitle: Text(subtitle),
  trailing: Row(

    mainAxisSize: MainAxisSize.min,
children: [

IconButton(onPressed: (){onPressed(title);  }, icon: Icon(Icons.delete,color: Colors.green))
,

IconButton(onPressed: (){popup(context,title,subtitle);  }, icon: Icon(Icons.remove_red_eye ,color: Colors.green))
,

IconButton(onPressed: (){update(context,title); }, icon: Icon(Icons.update ,color: Colors.green))




],


  )
          ),


            
          );
 


            },
          );
        },
      ),
    );
  }
}







