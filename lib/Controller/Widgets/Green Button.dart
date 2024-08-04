import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Views/Home%20Screen/Home%20Screen.dart';

class GreenButton extends StatelessWidget {
  String text='';
  double size;
  VoidCallback Ontap;
  GreenButton({super.key,required this.text,required this.Ontap,this.size=15});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(onTap: Ontap,
        child: Container(height: 40,width: double.infinity,
        decoration: BoxDecoration(color: Colors.teal,
        borderRadius: BorderRadius.circular(20)),
          child: Center(child: Text(text,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: size),)),
        ),
      ),
    );
  }
}


class GreenButtonwidget extends StatelessWidget {
  Widget widget;
  VoidCallback Ontap;
  GreenButtonwidget({super.key, required this.widget,required this.Ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(onTap: Ontap,
        child: Container(height: 40,width: double.infinity,
          decoration: BoxDecoration(color: Colors.teal,
              borderRadius: BorderRadius.circular(20)),
          child: Center(child: widget),
        ),
      ),
    );
  }
}
