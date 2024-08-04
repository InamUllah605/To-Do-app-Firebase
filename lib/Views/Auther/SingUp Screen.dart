import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Controller/Widgets/Constant/App%20Color.dart';
import 'package:todoappfirebase/Controller/Widgets/Green%20Button.dart';
import 'package:todoappfirebase/Controller/Widgets/TxtField.dart';
import 'package:todoappfirebase/Views/Auther/login%20Screen.dart';
import 'package:todoappfirebase/Views/Home%20Screen/Home%20Screen.dart';


class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {

  TextEditingController name=TextEditingController();
  TextEditingController phoneNumber=TextEditingController();
  TextEditingController emil=TextEditingController();
  TextEditingController possword=TextEditingController();
  TextEditingController repossword=TextEditingController();
  bool isLoading=false;
 Future<void> signup ()async
  {
    setState(() {
    isLoading=true;
    });

  await  FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emil.text.trim(),
        password: possword.text.trim()).then((value) {
          setState(() {
            isLoading=false;
          });
          emil.clear();
          possword.clear();
          Navigator.push(context, CupertinoPageRoute(builder: (context) => Login(),));
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Singup Sacessfully')));

          // snackbar
    //naviagtion tologin screen
  }).onError((error, stackTrace) {
    setState(() {
      isLoading=false;
    });
    print("Error=$error");

  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,top: 30),
                child: Image(image: AssetImage('assets/Singup.jpg')),
              ),
              //SizedBox(height: 140),
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
                      TxtField(controller: emil,lbltext: 'Email',icon: Icon(Icons.email_outlined)),
                      TxtField(controller: possword,lbltext: 'Possword',icon: Icon(Icons.lock_outlined)),
                      TxtField(controller: repossword,lbltext: 'RePossword',icon: Icon(Icons.lock_open)),
                      isLoading?CircularProgressIndicator():
                      GreenButtonwidget(Ontap: (){
                        if(name.text==''&& phoneNumber.text=='')
                          {

                          }
                        else
                          {
                            signup();

                          }

                       // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),));
                      },
                         widget: isLoading?CircularProgressIndicator():Text('Signup',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)   ),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an acount?",style: TextStyle(color: AppColor.Blackcolor)),
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
