import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Controller/Widgets/Constant/App%20Color.dart';
import 'package:todoappfirebase/Controller/Widgets/Green%20Button.dart';
import 'package:todoappfirebase/Controller/Widgets/TxtField.dart';
import 'package:todoappfirebase/Views/Auther/SingUp%20Screen.dart';
import 'package:todoappfirebase/Views/Home%20Screen/Home%20Screen.dart';
import 'package:todoappfirebase/firestore-project/firestore-addData.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();
  TextEditingController possword=TextEditingController();
  bool isLoading=false;
  Future<void> signin ()async
  {
    setState(() {
      isLoading=true;
    });
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(),
          password: possword.text.trim()).then((value) {
            setState(() {
              isLoading=false;
            });
            email.clear();
            possword.clear();
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>AddFDataScreen()));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Saucessfully')));

      }).onError((error, stackTrace) {
        setState(() {
          isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error:$error')));

      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,bottom: 20),
            child: Text('Welcome Back!',style: TextStyle(fontSize: 25,color: Colors.teal,fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 80,right: 80),
            child: Image(image: AssetImage('assets/Login.jpg')),
          ),
        Padding(
          padding: const EdgeInsets.only(left: 20,right: 20),
          child: Card(color: AppColor.Whitecolor,
            child: Padding(
              padding: const EdgeInsets.only(top: 20,),
              child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('Login',style: TextStyle(
                    fontSize: 30,color: AppColor.Greencolor,fontWeight: FontWeight.bold),),
              ),
              TxtField(controller: email,lbltext: 'Email',icon: Icon(Icons.email_outlined)),
              TxtField(controller: possword,lbltext: 'Possword',icon: Icon(Icons.lock_outlined)),
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forget Possword?',style: TextStyle(color: AppColor.forgetcolor),),
                  SizedBox(width: 10,),
                ],
              ),
              isLoading?CircularProgressIndicator():
              GreenButton(Ontap: () {
                signin();
                //Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),));
              },
                  text: 'Login'),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an acount?",style: TextStyle(color: AppColor.Blackcolor)),
                    TextButton(onPressed: (){
                      Navigator.push(context, CupertinoPageRoute(builder: (context) => SingUp(),));
                    }, child: Text("singup",style: TextStyle(color: AppColor.TxtButtoncolor),))
                  ],
                ),
                Text('or'),
                Padding(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    CircleAvatar(backgroundImage: AssetImage('assets/Google.jpg'),),
                    SizedBox(width: 10,),
                    CircleAvatar(backgroundImage: AssetImage('assets/Facebook.png',),radius: 18),
                    //Image(image: AssetImage('assets/Google.jpg'))
                  ],),
                ),

                        ],),
            ),),
        )
      ],)
    );
  }
}
