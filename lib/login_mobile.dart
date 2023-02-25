import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'custombuttom.dart';
import 'utils.dart';
import 'verify_otp.dart';

class Login_Mobile_OTP extends StatefulWidget {
  const Login_Mobile_OTP({Key? key}) : super(key: key);

  @override
  State<Login_Mobile_OTP> createState() => _Login_Mobile_OTPState();
}

class _Login_Mobile_OTPState extends State<Login_Mobile_OTP> {
  final mobilenumController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SingleChildScrollView(
                child: Form(
                    key: formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: _height * 0.4,
                            child: Image.asset(
                              'images/login.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: _height * 0.02),
                           Text(
                            "Login With Mobile Number",
                            style: TextStyle(
                                color: Colors.indigo[400],
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: _height * 0.14),
                          const Text(
                            'Mobile Number',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: _height * 0.01),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: mobilenumController,
                            validator:(value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              hintText: 'Enter Mobile No',
                              prefixIcon: Icon(Icons.phone),
                            ),
                          ),
                          SizedBox(height: _height * 0.05),
                          CustomButton(
                            txt: 'Login',
                            ontop: () {
                              if (formkey.currentState!.validate()) {
                                
                              setState(() {
                                loading = true;
                              });
                                  _auth.verifyPhoneNumber(
                                  phoneNumber: mobilenumController.text,
                                  verificationCompleted: (_) {
                                    setState(() {
                                      loading = false;
                                    });
                                  },
                                  verificationFailed: (e) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Utils().ToastMassage(e.toString());
                                  },
                                  codeSent:
                                      (String verificationId, int? Token) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Verify_OTP_Screen(
                                          Verificationid: verificationId);
                                    }));
                                  },
                                  codeAutoRetrievalTimeout: (e) {
                                    setState(() {
                                      loading = false;
                                    });
                                    Utils().ToastMassage(e.toString());
                                  });
                            
                              }
                            },
                            loading: loading,
                          )
                        ])))));
  }
}
