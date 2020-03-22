import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';
import 'HomePage.dart';
import 'Authentication.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;
   MappingPage(
     {this.auth,}
   );
  @override
  
  _MappingPageState createState() => _MappingPageState();
}

enum AuthStatus{
  signedin,
  notsignedin,
}

class _MappingPageState extends State<MappingPage> {

  AuthStatus authStatus = AuthStatus.notsignedin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserid){

      setState(() {
        authStatus = firebaseUserid == null ? AuthStatus.notsignedin : AuthStatus.signedin;
      });
    });
  }




  void _signedIn(){
    setState(() {
      authStatus = AuthStatus.signedin;
    });

  }

void _signedOut(){
    setState(() {
      authStatus = AuthStatus.notsignedin;
    });

  }

  @override
  Widget build(BuildContext context) {
    
    switch (authStatus) {
      case AuthStatus.notsignedin : return new Login(
        auth: widget.auth,
        onSignedIn: _signedIn,
      );
    
        
        break;

      case AuthStatus.signedin: return new HomePage(
        auth: widget.auth,
        onSignedOut: _signedOut,
      );
      break;
    
      default:
    }
  }
}