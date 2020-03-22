import 'dart:ffi';


import 'package:firebase_auth/firebase_auth.dart';
import 'Login.dart';


abstract class AuthImplementation{
Future<String> Signin(String email,String password);
Future<String> Signup(String email,String password);
Future<String> getCurrentUser();
Future<void> signOut();

}


class Auth implements AuthImplementation
{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String> Signin(String email,String password) async
  {
    //FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
         email: email.trim(), password: password);
     FirebaseUser user = result.user;
    
    
    return user.uid;
  }


  Future<String> Signup(String email,String password) async
  {
    //FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
         email: email.trim(), password: password);
     FirebaseUser user = result.user;
    
    
    return user.uid;
  }

  Future<String> getCurrentUser() async
  {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.uid;

  }

  Future<void> signOut() async  
  {
    _firebaseAuth.signOut();
  } 
}