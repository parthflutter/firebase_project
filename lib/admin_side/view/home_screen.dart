import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/admin_side/model/home_model.dart';
import 'package:firebase_project/ulitis/fbhelper_dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../controller/ecoomerce_controller.dart';

class Home_screen extends StatefulWidget {
  const Home_screen({Key? key}) : super(key: key);

  @override
  State<Home_screen> createState() => _Home_screenState();
}

class _Home_screenState extends State<Home_screen> {
  List Productlist = [];
  HomeController homeController = Get.put(HomeController());
  TextEditingController txtproduct = TextEditingController();
  TextEditingController txtprice = TextEditingController();
  TextEditingController txtcategory = TextEditingController();
  TextEditingController txtquantity = TextEditingController();
  TextEditingController txtimage = TextEditingController();
  TextEditingController txtdocid=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        floatingActionButton:FloatingActionButton(
          onPressed: (){
            Get.toNamed('/second');
          },
                    child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          title: Text("Food "),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
                onPressed: () async {
                  bool? msg = await Firebasehelper.fireHelper.logout();
                  if (msg = true) {
                    Get.offNamed("In");
                    Get.snackbar("True", "$msg");
                  }
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
          centerTitle: true,
        ),
        drawer: Drawer(
          child: Column(
            children: [
              CircleAvatar(
                radius: 20,
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Firebasehelper.fireHelper.readitem(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    List<Homemodel> datalist = [];
                    QuerySnapshot? snapData = snapshot.data;
                    String id="";
                    for (var x in snapData!.docs) {
                      id=x.id;
                      Map data = x.data() as Map;
                      String name = data['Name'];
                      String price = data['Price'];
                      String category = data['Category'];
                      String quantity = data['Quantity'];
                      String docid = id;
                      String image = data['Image'];
                      Homemodel homemodel = Homemodel(
                        name: name,
                        price: price,
                        category: category,
                        quantity: quantity,
                        image: image,
                        docid: docid,
                      );
                      datalist.add(homemodel);
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: datalist.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: 250,
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onDoubleTap: () async {
                              await  Firebasehelper.fireHelper.deleteitem(datalist[index].docid!);
                            },
                            onTap: () {
                             txtproduct=TextEditingController(text: datalist[index].name);
                             txtcategory=TextEditingController(text: datalist[index].category);
                             txtprice=TextEditingController(text: datalist[index].price);
                             txtquantity=TextEditingController(text: datalist[index].quantity);
                             txtimage=TextEditingController(text: datalist[index].image);
                            txtdocid=TextEditingController(text: datalist[index].docid);
                             showDialog(context: context, builder: (context) {
                               return Padding(
                                 padding: const EdgeInsets.all(10),
                                 child: AlertDialog(
                                   content: SingleChildScrollView(
                                     child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         TextField(
                                           controller: txtproduct,
                                           decoration: InputDecoration(
                                             focusedBorder: OutlineInputBorder(),
                                             labelStyle: TextStyle(color: Colors.black),
                                             enabledBorder: OutlineInputBorder(),
                                             hintText: "Enter Name",
                                             label: Text("Product Name")
                                           ),
                                         ),
                                         SizedBox(height: 2.h),
                                         TextField(
                                           controller: txtprice,
                                           decoration: InputDecoration(
                                             focusedBorder: OutlineInputBorder(),
                                             labelStyle: TextStyle(color: Colors.black),
                                             enabledBorder: OutlineInputBorder(),
                                             hintText: "Enter Price",
                                             label: Text("Product Price")
                                           ),
                                         ),
                                         SizedBox(height: 2.h),
                                         TextField(
                                           controller: txtcategory,
                                           decoration: InputDecoration(
                                             focusedBorder: OutlineInputBorder(),
                                             labelStyle: TextStyle(color: Colors.black),
                                             enabledBorder: OutlineInputBorder(),
                                             hintText: "Enter Category",
                                             label: Text("Product Category"),
                                           ),
                                         ),
                                         SizedBox(height: 2.h),
                                         TextField(
                                           controller: txtquantity,
                                           decoration: InputDecoration(
                                             focusedBorder: OutlineInputBorder(),
                                             labelStyle: TextStyle(color: Colors.black),
                                             enabledBorder: OutlineInputBorder(),
                                             hintText: "Enter Quantity",
                                             label: Text("Product Quantity"),
                                           ),
                                         ),
                                         SizedBox(height: 2.h),
                                         TextField(
                                           controller: txtquantity,
                                           decoration: InputDecoration(
                                             focusedBorder: OutlineInputBorder(),
                                             labelStyle: TextStyle(color: Colors.black),
                                             enabledBorder: OutlineInputBorder(),
                                             hintText: "Enter Image",
                                             label: Text("Product Image"),
                                           ),
                                         ),
                                         SizedBox(height: 2.h),
                                         ElevatedButton(onPressed: (){
                                           UpdateModal updateModel=UpdateModal(
                                          name: txtproduct.text,
                                          price: txtprice.text,
                                          category: txtcategory.text,
                                          quantity: txtquantity.text,
                                          image: txtimage.text,
                                          docid: datalist[index].docid,
                                           );
                                          Firebasehelper.fireHelper.update(updateModel);
                                          Get.back();
                                         }, child: Text("Update")),
                                       ],
                                     ),
                                   ),
                                 ),
                               );
                             },);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                height: 200.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      width: 1, color: Colors.yellowAccent.shade700),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(9),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Container(
                                            height:15.h,
                                            width: 35.w,
                                            color: Colors.red,
                                             child: Image.network("${datalist[index].image}",fit: BoxFit.cover,),
                                          ),
                                        ),
                                        SizedBox(height: 1.h),
                                        Row(
                                          children: [
                                            Text("${datalist[index].name}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        Text("\$ ${datalist[index].price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                        SizedBox(height: 1.h),
                                        Text(" ${datalist[index].quantity}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                        SizedBox(height: 1.h),
                                        Text(" ${datalist[index].category}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.white),),
                                        SizedBox(height: 1.h),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
