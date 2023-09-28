import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginp_page_hand_made/util/instagram_posts.dart';
import 'package:loginp_page_hand_made/util/text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();

  //user
  final currentUser = FirebaseAuth.instance.currentUser;

  void signOut(){
    FirebaseAuth.instance.signOut();
  }
  
  //post message
  void postMessage(){
    //only post if there is something in the textfield
    if(textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts").add({
        "UserEmail": currentUser!.email,
        "Message": textController.text,
        "TimeStamp": Timestamp.now(),
        
    });
    textController.clear();
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade700,
        elevation: 0,
        toolbarHeight: 70,
        title: const Text("Chatroom"),
        centerTitle: true,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey.shade400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: signOut, icon: const Icon(Icons.logout, size: 50,)),
            const SizedBox(height: 60,),
            const Text("SIGN OUT", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),)
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            //the wall
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("User Posts").orderBy(
                  "TimeStamp", 
                  descending: false
              )
              .snapshots(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                    //get the message
                    final post = snapshot.data!.docs[index];
                    return WallPost(
                      message: post["Message"], 
                      user: post["UserEmail"],
                    );
                  },);
                }else if(snapshot.hasError){
                  return Center(child: Text("ERROR${snapshot.hasError}"));
                }
                return const Center(
                  child: CircularProgressIndicator()
                );
              },
              ),
            ),
      
            //post message
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                   children: [
                    Expanded(
                      child: MyTextField(
                        controller: textController, 
                        hintText: "Post something fun", 
                        obscureText: false
                      )
                    ),
                    //post button
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0, bottom: 27),
                      child: IconButton(
                        onPressed: postMessage, 
                        icon: const Icon(Icons.arrow_circle_up_rounded, size: 60,)
                      ),
                    )
                   ],
                ),
              ),
      
            //as user
            Text("Logged in as: ${currentUser!.email!}"),
          ],
        ),
      ),
    );
  }
}