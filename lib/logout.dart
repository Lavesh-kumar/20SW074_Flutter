import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
class LogoutScreen extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LogoutScreen> {

@override
  void initState() {
    super.initState();
    fetchUserData();
  }


void fetchUserData()async{

User? user = FirebaseAuth.instance.currentUser;
if (user != null) {
  String uid = user.uid; // The user's unique ID



  print(user.email);
  // You can access other user properties as needed

setState(() {
  userEmail=user.email!;

});
}







}


  String userName=''; // Replace with actual user data
   String userEmail = ""; // Replace with actual user data



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 60,
              child: Icon(
                color: Colors.green,
                Icons.person,
                size: 80,
              ),
            ),
            SizedBox(height: 20),

            Text(
              userEmail,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
              onPressed: () {


 Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );


                // Implement your logout logic here
                // This could include clearing authentication tokens, logging the user out, etc.
                // Typically, you'd also navigate back to the login screen.
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
