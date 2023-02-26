// ignore_for_file: import_of_legacy_library_into_null_safe
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:video_app/view_video.dart';

import 'custombuttom.dart';
import 'postmodel.dart';
import 'utils.dart';

class Post_Videos extends StatefulWidget {
  const Post_Videos({super.key});

  @override
  State<Post_Videos> createState() => _Post_VideosState();
}

class _Post_VideosState extends State<Post_Videos> {
  final titlecontroller = TextEditingController();
  final discrpitionController = TextEditingController();
  bool loading = false;
  
  final fb = FirebaseDatabase.instance.reference().child("VideoLink");
  FirebaseAuth mAuth = FirebaseAuth.instance;
   UserCredential? credential;
  File? _video;
  final picker  = ImagePicker();
  Future _getvideoGallery(ImageSource source)async{
    final pickfile = await picker.pickVideo(source: source,preferredCameraDevice: CameraDevice.rear,maxDuration: const Duration(minutes: 5));
    // final pickfiled = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if(pickfile!=null){
        _video = File(pickfile.path);
      }else{
        Utils().ToastMassage('No Video Picked');
      }
    });
  }

  void showPhotoptions(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: const Text("Upload Video"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          ListTile(
            onTap: (){
              Navigator.pop(context);
              _getvideoGallery(ImageSource.gallery);
            },
            leading:const Icon(Icons.image),
            title:const Text('Upload video Gallery'),
          ),
          ListTile(
            onTap: (){
              Navigator.pop(context);
              _getvideoGallery(ImageSource.camera);
            },
            leading:const Icon(Icons.camera),
            title:const Text('Record and Upload video'),
          ),
        ],),
      );
    });
  }

    void checkvalues(){
    String fullname =
     titlecontroller.text.trim();
    String discrpition = discrpitionController.text.trim();
    if (fullname =='' ||discrpition == '' || _video == null) {
      setState(() {
        loading = false;
      });
      // UIHelper.showAlertDialog(context,'Error Occured', 'Please fill the fields');
      Utils().ToastMassage('Please Fill the fields');
    }else{
        uploadToStorage();
        setState(() {
          loading =true;
        });
    }
  }

Future uploadToStorage() async {
    var uuid =const Uuid();
    dynamic id=uuid.v1();
    try {
      mAuth.signInAnonymously().then((value)  async {
        Reference ref = FirebaseStorage.instance.ref().child("video").child(id);
        UploadTask uploadTask = ref.putFile(File(_video!.path), SettableMetadata(contentType: 'video/mp4'));
        var storageTaskSnapshot = await uploadTask;
        var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        final String url = downloadUrl.toString();
        fb.child(id).set({
          "id": id,
          "link": url,
          "title":titlecontroller.text.trim(),
          'discription':discrpitionController.text.trim()
        }).then((value) {
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const View_Video_list()));
          Utils().ToastMassage('Uploaded Video');
        });
      });
    } catch (error) {
      Utils().ToastMassage(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text("Post Videos"),centerTitle: true,automaticallyImplyLeading: false,),
      body: SafeArea(child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            InkWell(
              onTap: (){
                showPhotoptions();
              },
              child: (_video != null)?Container(
              height: 300,
              width: double.infinity,
              color: Colors.green[300],
              child: const Center(child: Text("Thank you For Upload Video",style: TextStyle(fontSize: 25,color: Colors.white),)),
            ): Container(
              height: 300,
              width: double.infinity,
              color: Colors.indigo[300],
              child: const Center(child: Text('upload Video', style: TextStyle(fontSize: 25,color: Colors.white),),),
            ),
            ),  
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            TextFormField(
              controller: titlecontroller,
              decoration: const InputDecoration(
                hintText: 'Enter Title',
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.02),
            TextFormField(
              controller: discrpitionController,
              decoration: const InputDecoration(
                hintText: 'Enter Discrpition'
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.05),
            CustomButton(txt: 'Post Video', loading: loading,ontop:(){
              checkvalues();
            })
          ],),
        ),
      )),
    );
  }
}