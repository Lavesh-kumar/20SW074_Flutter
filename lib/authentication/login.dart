import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../app.dart';
import '../user_provider.dart';
import 'register.dart';
void main() => runApp(
  
  MyApp()
  
  );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "contacts app",
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {




  
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _formKey = GlobalKey<FormState>();





  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
  try {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

            User? user = userCredential.user;

    if (user!= null) {
      // User is valid, store the user's ID in a variable
      String currentuser = user.uid;

print(currentuser);



final userProvider = Provider.of<UserProvider>(context, listen: false);
  userProvider.setUserId(user.uid);






      // Navigate to the next screen and pass the user ID
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(

          builder: (context) => todo( ),
        ),
      );
    } else {


      print("invalid");
      // User is not valid, show a Snackbar
      
    }
  } catch (e) {
    print("Error: $e");
    // Handle other authentication errors (e.g., display an error message).
  
ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User is not valid"),
        ),
      );






  
  
  }
}

















  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title:Text("contacts Manager App"),backgroundColor:Colors.green , ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(

              controller: _emailController,
                decoration: const InputDecoration(labelText: 'Username'),
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
                decoration: const InputDecoration(labelText: 'Password'),
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
const SizedBox(height: 20),
              // Date of Birth Field
 //---------------------------------             


//------------------------------------
              const SizedBox(height: 20),
//--------------------------------------
Row(         

mainAxisAlignment: MainAxisAlignment.center,
children: [

 ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
                onPressed: _login,
                child: const Text('Login'),
              ),

   SizedBox(width: 45.0),
   

 ElevatedButton(
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.green)),
                onPressed: ()=>{

Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterPage()),
            )


                },
                child: const Text('Signup'),
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

