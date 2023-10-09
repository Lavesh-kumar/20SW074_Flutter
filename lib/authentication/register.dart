import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'login.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
final _formKey = GlobalKey<FormState>();





  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();




Future<void> registernewUser() async {


final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

final String name = _emailController.text.trim();
    final String phone = _passwordController.text.trim();


  try {
    // Create user with email and password
    UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
//User? user =userCredential.user;
    // Get the newly created user's UID
    //if(userCredential.user){

      //String uid = userCredential.user.uid;
    //}
    

    // Store additional user data (user name) in Firestore
    //await FirebaseFirestore.instance.collection('users').doc(uid).set({
      //'email': email,
      //'userName': name,
    //});

    // Registration successful
   
   
   ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'User Registered Successfully!!',
          ),
        ),
      );
   
   Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => LoginPage(), // Replace NextScreen with the actual name of your screen.
    ),
  );
   
   
   
   
     } catch (e) {

      


String errorMessage = e.toString();
  // Check if the error message contains "[firebase_auth/email-already-in-use]"
  if (errorMessage.contains("[firebase_auth/email-already-in-use]")) {
    // Extract the desired error message
    int startIndex = errorMessage.indexOf("] ") + 2; // Index after "] "
    String errorText = errorMessage.substring(startIndex);
    print("Error message: $errorText");




   
   ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$errorText',
          ),
        ),
      );







  } else {
    // Handle other errors
    print("Error: $errorMessage");
  }















  }
}




































  void _submitform() {



    if (_formKey.currentState! .validate()) {

   
registernewUser();

    }
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title:Text("Register "),backgroundColor:Colors.green , ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(

              controller: _nameController,
                decoration: const InputDecoration(labelText: 'Enter the name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),


//------------------------------------------
              const SizedBox(height: 20),
//------------------------------------------              
              
              TextFormField(
                
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Enter password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                
              ),


//---------------------------------
const SizedBox(height: 40),
              // Age Field
 //---------------------------------             
   
              TextFormField(
                
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Enter your Mbile number'),
                obscureText: false,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid number';
                  }
                  if (value.length < 3) {
                    return 'Number must be at least 6 characters long';
                  }
                  return null;
                },
                
              ),




//------------------------------------
              const SizedBox(height: 40),
//--------------------------------------




   
              TextFormField(
                
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Enter your Email'),
                
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Email';
                  }
                  if (value.length < 6) {
                    return 'Email not valid ';
                  }
                  return null;
                },
                
              ),






//------------------------------------
              const SizedBox(height: 20),
//--------------------------------------




Row(         

mainAxisAlignment: MainAxisAlignment.center,
children: [

   
 ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
                onPressed: _submitform,
                child: const Text('Signup →'),
              ),



],
  
       ),

             
            ],
          ),
        ),
      ),
    );
  }
}
