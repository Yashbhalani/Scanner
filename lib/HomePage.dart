import 'package:blog_app/PhotoUpload.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'GridLayout.dart';
import './models/poststype.dart';
import 'package:firebase_database/firebase_database.dart';
import 'PhotoUpload.dart';
class  HomePage extends StatefulWidget {

  HomePage({
    this.auth,
    this.onSignedOut,
  });

   AuthImplementation auth;
  final VoidCallback onSignedOut;
  
  
  @override
_HomePageState createState() =>_HomePageState();
}


class _HomePageState extends State<HomePage> {
  
    List<poststype> postlist = [];

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference postsref = FirebaseDatabase.instance.reference().child("Posts");
    
    postsref.once().then((DataSnapshot snap)
    {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      postlist.clear();

      for(var individualkey in KEYS)
      {
        poststype posts = new poststype
        (
          DATA[individualkey]['image'],
          DATA[individualkey]['date'],
          DATA[individualkey]['time'],


        );

        postlist.add(posts);




      }

      setState(() {
       print("Lenghth:-  $postlist.length");
     });
    });
     
    
      }


   void _logoutuser() async {

     try{
       await widget.auth.signOut();
       widget.onSignedOut();
     }

     catch(e){
       print('error');
     }








   }
  
  
  
  
  
  
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),

      ),
      body: new Container(

        

        child: postlist.length == 0 ? Text("No Images"):new ListView.builder(
          itemCount: postlist.length,
          itemBuilder: (_,index){
            return Postui(postlist[index].image, postlist[index].date, postlist[index].time);
          },       
        
        
        
        ),












      ),

      bottomNavigationBar: new BottomAppBar(
        color: Colors.blue,
        
        child: new Container(
           margin: const EdgeInsets.only(left: 50.0,right:50.0),
          child:new Row( 
            mainAxisAlignment:
             MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,

            children: <Widget>[
              
              new IconButton(
                icon: new Icon(Icons.home), 
                onPressed: () {
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)
                  {
                    return new GridLayout();
                  }
                  )
                  );
                },
                                              iconSize: 50,
                                color: Colors.white,
                
                              ),
              











              new IconButton(
                icon: new Icon(Icons.settings_power), onPressed: _logoutuser,
                                              iconSize: 50,
                                color: Colors.white,
                
                              )
                
                            ],
                
                          )
                        ),
                      ),
                    );
                  }
                
              
              Widget Postui(String image,String date,String time){

                return new Card(
                  elevation: 10.0,
                  margin: EdgeInsets.all(14.0),
                  child: new Container(

                    padding: EdgeInsets.all(14.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                          date,
                          style: Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,
                        ),


                        new Text(
                          time,
                          style: Theme.of(context).textTheme.subtitle,
                          textAlign: TextAlign.center,
                        )










                          ] 
                        ),
                       SizedBox(height: 10.0,),
                        new Image.network(image,fit: BoxFit.cover,),
                       //new Image.network(image,fit:BoxFit.cover),

                      ],

                                          ),


                  ),
                );

              }
}