import 'package:blog_app/Authentication.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {

 Login({
   this.auth,
   this.onSignedIn, 
   
 });
  final AuthImplementation auth;
  final VoidCallback onSignedIn;
  @override
  _LoginState createState() => _LoginState();
}

enum FormType{
  login,
  register,
}

class _LoginState extends State<Login> {
final formkey = new GlobalKey<FormState>();
final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController(); 
FormType _formType = FormType.login;
String _email = "";
String _password="";

void moveTologin() {
    formkey.currentState.reset();

    setState(() {
      _formType=FormType.login;
      
    });

        }
      

  void moveToregister() {
    formkey.currentState.reset();

    setState(() {
      _formType=FormType.register;

    });

        }
      
  bool ValidateAndSave() {
      final form = formkey.currentState;

      if(form.validate()){
        form.save();
        print("success");
        return true;
      }
      else{
        return false;
      }
  }

  void ValidateAndSubmit() async{

    if(ValidateAndSave())
    {
      String userId="";
      
        if(_formType == FormType.login){

          String userId = await widget.auth.Signin(_email, _password);
         }
        else{
          String userId = await widget.auth.Signup(_email, _password);
        }
        widget.onSignedIn();
        
      
      


    }
  }










  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      appBar: new AppBar(
        title: new Text('NEW'),
      ),

      body: Container(
        child:SingleChildScrollView(
          padding: EdgeInsets.all(15.0),
        child: new Form(

          key: formkey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          )
          ),
        ),
        
      ),
      
  
        
      );
  }

  List<Widget>createInputs()
  {
    return [
      SizedBox(height: 10.0),
      Logo(),
      SizedBox(height: 20.0),

      new TextFormField(
        decoration:  new InputDecoration(labelText: 'Email'),
        validator: (value){
          return value.isEmpty ? "Email is required" : null;

        },

        onSaved: (value){
          return _email =value;
          
        },

        
      ),


SizedBox(height: 10.0),

    new TextFormField(
      controller: _pass,
        decoration:  new InputDecoration(labelText: 'Password'),
        obscureText: true,
      validator: (value){
          return value.isEmpty ? "Password is required" : null;

        },

        onSaved: (value){
          return _password =value;
          
        },

      ),
      SizedBox(height: 20.0),

    ];
  }

 Widget Logo()
 {
   
   return new Hero(
     tag: 'Hero',
    child: new CircleAvatar(
     backgroundColor: Colors.transparent,
     child: Image.asset('assests/bg.png'),
     radius: 10.0,
   ), );
 }


List<Widget>createButtons()
  {
   if(_formType==FormType.login){

     return[
      new RaisedButton(onPressed: ValidateAndSubmit,
            
            child:new Text("Login"),
            textColor: Colors.white,
            color: Colors.pink,
            
            ),
      
            new FlatButton(onPressed: moveToregister,
                  
                  child:new Text("Create Account?"),
                  textColor: Colors.white,
                  color: Colors.pink, )
          
 ];

   }             
   else{


     return[
       new TextFormField(
         controller: _confirmPass,
                           validator: (val){
                              if(val.isEmpty)
                                   return 'Empty';
                              if(val != _pass.text)
                                   return 'Not Match';
                              return null;
                              },
        decoration:  new InputDecoration(labelText: ' Confirm Password'),
        obscureText: true,
      ),

        SizedBox(height: 20.0),
      new RaisedButton(
        
        onPressed: ValidateAndSubmit,
            
            child:new Text("Register"),
            textColor: Colors.white,
            color: Colors.pink,
            
            ),
      
            new FlatButton(onPressed: moveTologin,
                  
                  child:new Text("wanna Login?"),
                  textColor: Colors.white,
                  color: Colors.pink, )
          
 ];
   }
  
  
  
  
  
  
  
  
  }
            
}



