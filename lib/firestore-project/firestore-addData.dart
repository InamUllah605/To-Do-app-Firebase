import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoappfirebase/Controller/Widgets/Green%20Button.dart';

class AddFDataScreen extends StatefulWidget {
  const AddFDataScreen({super.key});

  @override
  State<AddFDataScreen> createState() => _AddFDataScreenState();
}

class _AddFDataScreenState extends State<AddFDataScreen> {
  TextEditingController namecontroller=TextEditingController();
  TextEditingController fathernamecontroller=TextEditingController();
  TextEditingController coursenamecontroller=TextEditingController();
  TextEditingController feecontroller=TextEditingController();
  // addData()async
  // {
  //   print('button pressing');
  //   await FirebaseFirestore.instance.collection('Inaam').add({
  //     'studentName':namecontroller.text,
  //     'fatherName':fathernamecontroller.text,
  //     'courseName':coursenamecontroller.text,
  //     'fee':feecontroller.text,
  //   }).then((value) {
  //     print('data added');
  //   }).onError((error, stackTrace) {
  //     print('Added:$error');
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Add your Data',style: TextStyle(fontSize: 20,color: Colors.blue),),
            Center(child: Padding(
              padding: const EdgeInsets.only(left: 20,right: 20,top: 10),
              child: Card(child: Container(width: double.infinity,decoration: BoxDecoration(
                  color: Colors.lightBlue,borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(controller: namecontroller,decoration: InputDecoration(
                        label: Text('Name',style: TextStyle(color: Colors.white),)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(controller: fathernamecontroller,decoration: InputDecoration(
                        label: Text('Father Name',style: TextStyle(color: Colors.white),)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(controller: coursenamecontroller,decoration: InputDecoration(
                        label: Text('course Name',style: TextStyle(color: Colors.white),)),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextFormField(controller: feecontroller,decoration: InputDecoration(
                        label: Text('fee',style: TextStyle(color: Colors.white),)),),
                  ),
                  SizedBox(height: 20,),
                  GreenButton(text: 'Save', Ontap: (){})
                  // WhiteButton(text: 'Save',size: 25, Ontap: (){
                  //   //addData();
                  //
                  // },)
                ],),
              )),
            ))
          ],)
    );
  }
}
