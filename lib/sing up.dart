import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Controller/Widgets/Constant/App%20Color.dart';
import 'package:todoappfirebase/Controller/Widgets/Green%20Button.dart';
import 'package:todoappfirebase/Controller/Widgets/TxtField.dart';

class singup extends StatefulWidget {
  const singup({super.key});

  @override
  State<singup> createState() => _singupState();
}

class _singupState extends State<singup> {
  TextEditingController name=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController repossword=TextEditingController();
  bool isloading=false;

  Future<void> singUP() async{
    setState(() {
      isloading=true;
    });
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), password: password.text.trim()
    ).then((value) {
      setState(() {
        isloading=false;
      });
      email.clear();
      password.clear();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Singup Sucessfully')));


    }).onError((error, stackTrace) {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Card(color: AppColor.Whitecolor,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20,),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text('SingUp',style: TextStyle(fontSize: 30,color: AppColor.Greencolor,fontWeight: FontWeight.bold),),
                      ),
                      TxtField(controller: name,lbltext: 'Name',icon: Icon(Icons.person_outlined)),
                      TxtField(controller: phoneNumber,lbltext: 'Phone Number',icon: Icon(Icons.phone)),
                      TxtField(controller: email,lbltext: 'Email',icon: Icon(Icons.email_outlined)),
                      TxtField(controller: password,lbltext: 'Possword',icon: Icon(Icons.lock_outlined)),
                      TxtField(controller: repossword,lbltext: 'RePossword',icon: Icon(Icons.lock_open)),
                      isloading?CircularProgressIndicator():
                      GreenButton(Ontap: (){
                        singUP();
                        //signup();
                        // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),));
                      },
                          text: 'SingUp'),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("have an acount?",style: TextStyle(color: AppColor.Blackcolor)),
                          TextButton(onPressed: (){
                            Navigator.pop(context);
                          }, child: Text("login",style: TextStyle(color: AppColor.TxtButtoncolor),))
                        ],
                      ),

                    ],),
                  ),),
              )
            ],),
        )
    );
  }
}
