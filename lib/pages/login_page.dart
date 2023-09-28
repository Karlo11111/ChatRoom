

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginp_page_hand_made/util/login_button.dart';
import 'package:loginp_page_hand_made/util/text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sing in method
  void signIn() async {
    //show loading circle
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),);
    //try sign in 
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailTextController.text, 
      password: passwordTextController.text,
    );  
    //pop loading circle  
    if(context.mounted) Navigator.pop(context);
    //catch errors
  } on FirebaseAuthException catch (e){
      //pop loading circle
      Navigator.pop(context);
      //display if there's an error while logging in
      displayMessage(e.code);
    }
  }

  //display the errors
  void displayMessage(String message){
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(message),
        ),
      )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    //LOGO
                    const Icon(Icons.lock, size: 100,),
                    
                    //SIZED BOX
                    const SizedBox(height: 50),
        
                    //TEXT
                    const Text("Welcome back, you've been missed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          
                    //SIZED BOX
                    const SizedBox(height: 15),
        
                    //TEXTFIELDS FOR EMAIL AND PASSWORD
                    //email
                    MyTextField(
                      controller: emailTextController, 
                      hintText: "Enter your email", 
                      obscureText: false,
                    ),
                    const SizedBox(height: 10),
                    //password
                    MyTextField(
                      controller: passwordTextController,
                      hintText: "Enter your password",
                      obscureText: true,
                    ),
                    const SizedBox(height: 10),
                    //LOG IN BUTTON
                    Button(
                      buttonText: "SIGN IN", ontap: signIn,
                    ),
                    //SIZED BOX
                    const SizedBox(height: 15),
                    
                    //TEXT WITH REGISTER PAGE TEXT
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Not a member?"),
                        const SizedBox(width: 5,),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text("Register Now!", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),)
                        ),
                      ],
                    )
                    
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}