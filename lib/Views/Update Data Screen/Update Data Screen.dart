import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Controller/Widgets/Constant/App%20Color.dart';
import 'package:todoappfirebase/Controller/Widgets/Green%20Button.dart';

class UpdateDataScreen extends StatefulWidget {
  String id;
  String name;
  String fathername;
  String userEmail;
   UpdateDataScreen({super.key, required this.id,required this.name,required this.fathername, required this.userEmail});

  @override
  State<UpdateDataScreen> createState() => _UpdateDataScreenState();
}

class _UpdateDataScreenState extends State<UpdateDataScreen> {
  TextEditingController titleconroller= TextEditingController();
  TextEditingController messageconroller= TextEditingController();
  bool isLoading= false;
  void updateData()
  {
    setState(() {
      isLoading=true;
    });
    FirebaseDatabase.instance.ref(widget.userEmail).child(widget.id).update(
        {
          'id': widget.id,
          'name':titleconroller.text.toString(),
          'fathername':messageconroller.text.toString()
        }).then((value) {
          setState(() {
           isLoading= false;
          });
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data update Saucessfully')));
    }).onError((error, stackTrace){
      setState(() {
        isLoading=false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent,content: Text('error:$error')));

    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleconroller.text=widget.name;
    messageconroller.text=widget.fathername;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Update your Data',style: TextStyle(fontSize: 20,color: AppColor.Greencolor),),
          Center(child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
            child: Card(child: Container(height: 220,width: double.infinity,decoration: BoxDecoration(
                color: Colors.teal,borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(controller: titleconroller,decoration: InputDecoration(
                      label: Text('Update Title',style: TextStyle(color: Colors.white),)),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextFormField(controller: messageconroller,decoration: InputDecoration(
                      label: Text('Update Message',style: TextStyle(color: Colors.white),)),),
                ),
                SizedBox(height: 20,),
                isLoading?CircularProgressIndicator():
                GreenButton(text: 'Update', Ontap: (){
                  updateData();
                },size: 25,)
              ],),
            )),
          ))
        ],)
    );
  }
}
