import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Views/Auther/login%20Screen.dart';
import 'package:todoappfirebase/Views/Home%20Screen/Home%20Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),() {
      (FirebaseAuth.instance.currentUser==null)?
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => Login(),)):
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height:300,),
            Container(height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/Todo.png'))),),
            SizedBox(height: 10,),
            Text('To Do',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
            SizedBox(height:300,),
            Text('Develped by inamullah',style: TextStyle(color: Colors.black38),)
          ],
        ),
      ),
    );
  }
}
