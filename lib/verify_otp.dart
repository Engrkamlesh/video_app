// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custombuttom.dart';
import 'utils.dart';
import 'view_video.dart';

class Verify_OTP_Screen extends StatefulWidget {
  final String Verificationid;
  const Verify_OTP_Screen({super.key, required this.Verificationid});

  @override
  State<Verify_OTP_Screen> createState() => _Verify_OTP_ScreenState();
}

class _Verify_OTP_ScreenState extends State<Verify_OTP_Screen> {
final verifyController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery
        .of(context)
        .size
        .height * 0.8;
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  SizedBox(height: _height * 0.2),
                  const Text(
                      "Verify Your OTP Code",
                      style:TextStyle(
                          color: Colors.indigo,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                      ),
                      
                  SizedBox(height: _height * 0.8),
                  const Text('Please check your inbox, we will send you OTP code on your Mobile Number'),
                  SizedBox(height: _height * 0.14),
                  const Text('OTP Code', style:TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w600),),
                  SizedBox(height: _height * 0.01),
                  TextFormField(
                    controller: verifyController,
                        validator:(value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                    hintText: 'Enter 6 digits OTP',
                    prefixIcon: Icon(Icons.phone),
                  ),),
                  SizedBox(height: _height * 0.05),
                      CustomButton(txt: 'Verfiy OTP', ontop: (){
                        setState(() {
                          loading = true;
                        });
                        if (formkey.currentState!.validate()) {
                             final credential = PhoneAuthProvider.credential
                        (verificationId: widget.Verificationid,
                         smsCode: verifyController.text.toString());
                         try {
                           _auth.signInWithCredential(credential);
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>const View_Video_list()));
                         } catch (e) {
                          setState(() {
                            loading = false;
                          });
                           Utils().ToastMassage(e.toString());
                         }
                        }
                      },loading: loading,)
                ])
            )
        )
    ));
  }

}