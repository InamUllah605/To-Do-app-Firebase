

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoappfirebase/Controller/Widgets/Constant/App%20Color.dart';
import 'package:todoappfirebase/Views/Add%20Data%20Screen/Add%20Data%20Screen.dart';
import 'package:todoappfirebase/Views/Auther/login%20Screen.dart';
import 'package:todoappfirebase/Views/Update%20Data%20Screen/Update%20Data%20Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchFilter=TextEditingController();
  bool dataMatched=false;
  String userEmail='';
  String mail='';
  fetchEmail()
  {
    final user=FirebaseAuth.instance.currentUser;
    if(user!=null)
      {
        userEmail=user.uid??'';
        mail=user.email??'';
        setState(() {
          
        });
        //userEmail=user.uid;
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchEmail();
    //print('UserEmail:$userEmail');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(children: [
          UserAccountsDrawerHeader(
             currentAccountPicture: CircleAvatar(backgroundColor: Colors.black,
               backgroundImage: AssetImage('assets/Todo.png'),
             ),
            // Container(
            //   height: 40,
            //   child: Image.asset('assets/Todo.png'),
            // ),
            decoration: BoxDecoration(
              color: Colors.teal
            ),
              accountName: Text('Email:$mail',style: TextStyle(color: AppColor.Whitecolor),),
              accountEmail: Text(''),),
          ListTile(onTap: (){Navigator.pop(context);}, leading: Icon(Icons.home_outlined,),title: Text('Home')),
          ListTile(onTap: (){
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddDataScreen(userEmail: userEmail)));
          }, title: Text('Add Data'),leading: Icon(Icons.note_add_sharp)),
          ListTile(onTap: ()
          async
          {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>Login()));
          },
            leading: Icon(Icons.logout),title: Text('Logout'),)
        ],),
      ),
      appBar: AppBar(backgroundColor: AppColor.Greencolor,
        title: Text('T o Do List',style: TextStyle(fontSize: 30,color: Colors.white),),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        children: [
          Container(color: AppColor.Greencolor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
              child: TextFormField(
                decoration: InputDecoration(fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search,color: Colors.white),
                  label: Text('Search',style: TextStyle(color: Colors.white),),
                  border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.white70)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white70))
                ),
                controller: searchFilter,
                onChanged: (String value){
                  setState(() {
                    dataMatched=false;
                  });
                },

              ),
            ),
          ),
          SizedBox(height: 10,),
          Expanded(
             child: FirebaseAnimatedList(
                  query: FirebaseDatabase.instance.ref(userEmail),
                  defaultChild: Center(child: Image(image: AssetImage('assets/no data found.jpg'))),
                  itemBuilder: (context,snapshot,animation,index)
                  {
                    String name=snapshot.child('name').value.toString();
                    String fathername=snapshot.child('fathername').value.toString();
                    String id=snapshot.child('id').value.toString();
                    if(searchFilter.text.isEmpty)
                      {dataMatched=true;
                        return Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10,),
                          child: Card(color: Colors.white,
                            child: ListTile(
                              //leading: CircleAvatar(radius: 30,),
                              title: Text(name,style: TextStyle(color: Colors.teal,fontWeight: FontWeight.bold),),
                              subtitle: Text(fathername),
                              trailing: PopupMenuButton<String>(
                                onSelected: (String value) {
                                  if(value=='delete'){
                                    Get.defaultDialog(title: 'Are you Sure?',
                                      actions: [
                                        TextButton(onPressed: (){
                                          Get.back();
                                        }, child: Text('Cancel')),
                                        TextButton(onPressed: (){
                                          FirebaseDatabase.instance.ref(userEmail).child(id).remove().then((value) {

                                          }).onError((error, stackTrace) {
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent,content: Text('error:$error')));
                                          });
                                          Get.back();
                                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data delete Saucessfully')));
                                        }, child: Text('Confirm'))
                                      ]
                                    );
                                    // FirebaseDatabase.instance.ref('inaam').child(id).remove().then((value) {
                                    //
                                    // }).onError((error, stackTrace) {
                                    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.redAccent,content: Text('error:$error')));
                                    // });
                                  }
                                  if(value=='edit'){
                                    // Get.defaultDialog(title: 'Are you Sure?',
                                    // actions: [
                                    //   TextButton(onPressed: (){
                                    //     Get.back();
                                    //   }, child: Text('Cancel')),
                                    //   TextButton(onPressed: (){
                                    //     Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpdateDataScreen(
                                    //       userEmail: userEmail,
                                    //       id: id,name: name,fathername: fathername,)));
                                    //     }, child: Text('Confirm'))
                                    // ]
                                    // );
                                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>UpdateDataScreen(
                                      userEmail: userEmail,
                                      id: id,name: name,fathername: fathername,)));
                                  }
                                },
                                itemBuilder: (context) => [
                                PopupMenuItem<String>(
                                  value: 'delete',
                                  child: ListTile(
                                  title: Text('Delete'),
                                  leading: Icon(Icons.delete),),
                                ),
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: ListTile(
                                  title: Text('Edit'),
                                  leading: Icon(Icons.edit),),
                                )
                              ],),

                            ),
                          ),
                        );
                      }
                    else if(name.toLowerCase().contains(searchFilter.text.toLowerCase().toString()))
                      {
                        dataMatched=true;
                        return ListTile(
                          title: Text(snapshot.child('name').value.toString()),
                          subtitle: Text(snapshot.child('fathername').value.toString()),
                        );
                      }
                    else if(index==0&&!dataMatched){
                      return Center(child: Text('No data Matched'),);
                    }
                    else return Container();


                  }
                  ),
           ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>AddDataScreen(userEmail: userEmail,)));
      },
          backgroundColor: Colors.teal,
        child: Icon(Icons.add,size: 30,color: Colors.white,)),
    );
  }
}
