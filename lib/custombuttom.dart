import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String txt;
  final bool loading;
  final VoidCallback ontop;
  const CustomButton({super.key,
   required this.txt,
    this.loading = false,
    required this.ontop});

  @override
  Widget build(BuildContext context) {
    return InkWell(
                      onTap: ontop,
                      child: Container(
                        height: 45,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(10)),
                        child:Center(
                          child:loading?CircularProgressIndicator(color: Colors.white,):Text(
                            txt,
                    style:  TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    );
  }
}