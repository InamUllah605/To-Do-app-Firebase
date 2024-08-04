import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Controller/Widgets/Constant/App%20Color.dart';
import 'package:todoappfirebase/Controller/Widgets/Green%20Button.dart';
import 'package:todoappfirebase/Controller/Widgets/TxtField.dart';
import 'package:todoappfirebase/Views/Home%20Screen/Home%20Screen.dart';

class AddDataScreen extends StatefulWidget {
  String userEmail;
   AddDataScreen({super.key,required this.userEmail});

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  TextEditingController titleconroller= TextEditingController();
  TextEditingController messageconroller= TextEditingController();

  bool isLoading= false;
  String userEmail='';
  // fetchEmail()
  // {
  //   final user=FirebaseAuth.instance.currentUser;
  //   if(user!=null)
  //   {
  //     userEmail=user.uid??'';
  //     //userEmail=user.uid;
  //   }
  // }

  void _insertData()
  {
    setState(() {
      isLoading=true;
    });
    //fetchEmail();
    print('Adding button press:${widget.userEmail}');
    String id=DateTime.now().millisecondsSinceEpoch.toString();
    FirebaseDatabase.instance.ref(widget.userEmail).child(id).set({
      'name':titleconroller.text,
      'fathername':messageconroller.text,
      'id':id,

    }).then((value)
    {
      setState(() {
        isLoading=false;
      });
      Navigator.pop(context);
      //Navigator.pushReplacement(context, CupertinoPageRoute(builder:(context) => HomeScreen()));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data add Saucessfully')));
      // back to screen
    }).onError((error, stackTrace)
    {
      setState(() {
        isLoading=false;
      });
      print('Error:$error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent,content: Text('error:$error')));
      // show error message
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Add your Data',style: TextStyle(fontSize: 20,color: AppColor.Greencolor),),
        Center(child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
          child: Card(child: Container(height: 220,width: double.infinity,decoration: BoxDecoration(
            color: Colors.teal,borderRadius: BorderRadius.circular(10)),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(controller: titleconroller,decoration: InputDecoration(
                    label: Text('Title',style: TextStyle(color: Colors.white),)),),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextFormField(controller: messageconroller,decoration: InputDecoration(
                    label: Text('Message',style: TextStyle(color: Colors.white),)),),
              ),
              SizedBox(height: 20,),
              isLoading?CircularProgressIndicator():
              GreenButton(text: 'Save',size: 25, Ontap: (){
                if(titleconroller.text!=""&&messageconroller.text!=""){
                  _insertData();
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please! fill this')));

                }

              },)
            ],),
          )),
        ))
      ],)
    );
  }
}
