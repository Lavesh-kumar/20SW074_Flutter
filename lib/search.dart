import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class searchbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Search'),
        ),
        body: UserList(),
      ),
    );
  }
}

class UserList extends StatefulWidget {





  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _usersStream;

  @override
  void initState() {
    super.initState();
    _usersStream = _firestore.collection('users').snapshots();
  }



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













  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            onChanged: (query) {
              // Update the stream based on the search query
              setState(() {
                _usersStream = _firestore
                    .collection('users')
                    .where('name', isGreaterThanOrEqualTo: query)
                    .where('name', isLessThanOrEqualTo: query + '\uf8ff')
                    .snapshots();
              });
            },
            decoration: InputDecoration(
              hintText: 'Search by name',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              final documents = snapshot.data!.docs;

              if (documents.isEmpty) {
                return Text('No users found');
              }

              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final userData = documents[index].data() as Map<String, dynamic>;
                
                   
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
title: Text(userData['name']),
 
  subtitle: Text(userData['number']),
  trailing: Row(

    mainAxisSize: MainAxisSize.min,
children: [

// IconButton(onPressed: (){onPressed(title);  }, icon: Icon(Icons.delete,color: Colors.green))
// ,

 IconButton(onPressed: (){popup(context,userData['name'],userData['number']);  }, icon: Icon(Icons.remove_red_eye ,color: Colors.green))
// ,

// IconButton(onPressed: (){update(context,title); }, icon: Icon(Icons.update ,color: Colors.green))




],


  )
          ),


            
          );

                
                
                
                
                





















                
                },
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
