import 'package:blog_app/Authentication.dart';
import 'package:blog_app/Login.dart';
import 'package:blog_app/Mapping.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(new BlogApp());
  }
  
class BlogApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Scanner',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MappingPage(auth: Auth(),),



    );
  }
}