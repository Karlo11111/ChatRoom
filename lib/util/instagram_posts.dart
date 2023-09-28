import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  final String user;

  const WallPost({super.key, required this.message, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      margin: EdgeInsets.only(top: 25, left: 25, right: 25),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50.0, top: 12, bottom: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //the message 
                Text(message, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),

                const SizedBox(height: 10,),
                //email of the user
                Text(user, style: TextStyle(fontWeight: FontWeight.w200),),
              ],
            ),
          )
    
        ],
      ),
    );
  }
}