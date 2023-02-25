import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import 'post_video.dart';

class View_Video_list extends StatefulWidget {
  const View_Video_list({super.key});

  @override
  State<View_Video_list> createState() => _View_Video_listState();
}

class _View_Video_listState extends State<View_Video_list> {

    final auth = FirebaseAuth.instance;
    final ref = FirebaseDatabase.instance.ref('VideoLink');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video List"),centerTitle: true,),
      body: SafeArea(
        child:Expanded(child: FirebaseAnimatedList(
          query: ref,
          defaultChild: Center(child: CircularProgressIndicator()),
          itemBuilder: (context,snapshot, animation, Index){
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Container(width: double.infinity,
                    height: 250,
                    color: Colors.deepOrange,
                    ),
                    snapshot.child('title').value.toString().text.size(20).bold.make().py12(),
                    snapshot.child('discription').value.toString().text.size(12).make(),
                  ],),
            );
        })) 
      ),


      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Post_Videos()));
      },child: Icon(Icons.add),),
    );
  }
}