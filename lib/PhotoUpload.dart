import 'package:blog_app/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UploadPhotoPage extends StatefulWidget {
  @override
  _UploadPhotoPageState createState() => _UploadPhotoPageState();
}

class _UploadPhotoPageState extends State<UploadPhotoPage> {
  File sampleImage;
  String url;
  Future getImage() async{

    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage;
    });
  }
 
  void uploadImage() async{

      final StorageReference postrefimage = FirebaseStorage.instance.ref().child("POST IMAGE");
      var timeKey = new DateTime.now();
      final StorageUploadTask uploadTask = postrefimage.child(timeKey.toString() + ".jpg").putFile(sampleImage);
      uploadTask.pause();
      uploadTask.resume();
      uploadTask.cancel();



      var imageurl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageurl.toString();
      print("Imageurl" + url);
      gotoHomePage();
      saveToDatabase(url); 
  }
 
 void gotoHomePage() {

   Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)
                  {
                    return new HomePage();
                  }
                  )
                  );
 }
 
  void saveToDatabase(url){
     var dbtimeKey = DateTime.now();  //role as primary key
     var formatDate = new DateFormat('MMM d,yyyy');  
     var formatTime = new DateFormat('EEEE, hh:mm aaa');

     String date = formatDate.format(dbtimeKey);
     String time = formatTime.format(dbtimeKey);
     DatabaseReference dbref = FirebaseDatabase.instance.reference();

     var data = {
       "image" : url,
       "date" : date,
       "time" : time,
     };

     dbref.child('Posts').push().set(data);
  }

 
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Upload image"),
        centerTitle: true,
      ),

      body: new Center(
        child: sampleImage==null ? Text("Select an Image") : enableUpload(),    ),

        floatingActionButton: new FloatingActionButton(onPressed: getImage,
        tooltip: 'AddImage',
        child: new Icon(Icons.image)),
      
    );
  }
 

Widget enableUpload()
{

  return new Container(

    child: new Form(
    
    child: Column(children: <Widget>[

      Image.file(sampleImage,height: 330 , width: 660,),
      SizedBox(height: 30.0),

      RaisedButton(
      onPressed: uploadImage,
      elevation: 10.0,
      child: Text("Post image"),),


 //RaisedButton(
   //   onPressed: uploadImage,
     // elevation: 10.0,
      //child: Text("Post image"),)
    







    ],)),
  );
  
}





} 
 
    
    
 
 
 