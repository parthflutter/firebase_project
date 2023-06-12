import 'package:firebase_project/ulitis/fbhelper_dart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class second_screen extends StatefulWidget {
  const second_screen({Key? key}) : super(key: key);

  @override
  State<second_screen> createState() => _second_screenState();
}

class _second_screenState extends State<second_screen> {
  TextEditingController txtproduct=TextEditingController();
  TextEditingController txtprice=TextEditingController();
  TextEditingController txtcategory=TextEditingController();
  TextEditingController txtquantity=TextEditingController();
  TextEditingController txtimage=TextEditingController();
  TextEditingController txtdocid=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Product Add"),

        backgroundColor: Colors.black,

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(13),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtproduct,
                decoration: InputDecoration(
                  label: Text("Product Name"),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: txtprice,
                decoration: InputDecoration(
                  label: Text("Product Price"),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Product Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: txtcategory,
                decoration: InputDecoration(
                  label: Text("Product Category"),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Product Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                controller: txtquantity,
                decoration: InputDecoration(
                  label: Text("Product Quantity"),
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: "Product Quantity",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              TextField(
                  controller: txtimage,
                  decoration: InputDecoration(
                      label: Text("Product Image"),
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                  ),
              ),
              SizedBox(height: 2.h),
              ElevatedButton(onPressed: () {
                Firebasehelper.fireHelper.insertitem(
                  Name: txtproduct.text,
                    Quantity: txtquantity.text,
                    Category: txtcategory.text,
                    Price: txtprice.text,
                  Image: txtimage.text,
                  Docid: txtdocid.text, Id: null,
                );
                Get.toNamed("/home");
              },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),

                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
