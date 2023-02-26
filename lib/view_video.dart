// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:video_app/post_video.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:video_app/video_play_apk.dart';

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
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Video List"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child:Expanded(
              child:FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Center(child: CircularProgressIndicator()),
                  itemBuilder: (context, snapshot, animation, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left:10,right: 10,top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            // height: 250,
                            color: Colors.deepOrange,
                            child: chewie_video_Play(url: snapshot.child('link').value.toString(),),
                          ),
                          snapshot
                              .child('title')
                              .value
                              .toString()
                              .text
                              .size(20)
                              .bold
                              .make()
                              .py12(),
                          snapshot
                              .child('discription')
                              .value
                              .toString()
                              .text
                              .size(12)
                              .make(),
                        ],
                      ),
                    );
                  }))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Post_Videos()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
