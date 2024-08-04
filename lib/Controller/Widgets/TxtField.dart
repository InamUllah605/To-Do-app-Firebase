import 'package:flutter/material.dart';

class TxtField extends StatelessWidget {
String  lbltext="";
Icon icon=Icon(Icons.email);
TextEditingController controller;
   TxtField({super.key,this.lbltext='email',required this.icon,required this.controller,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(label: Text(lbltext),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.black38)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(color: Colors.teal)),
            suffixIcon: IconButton(onPressed: (){
            }, icon: icon,color: Colors.black38,
        ),

      ),)
    );
  }
}
