import 'package:flutter/material.dart';
import 'character_listing_screen.dart';
class GridLayout extends StatelessWidget {
  List<String> events = ["Scan", "History", "Team", "Info"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text('ScanDigi'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.menu), onPressed: null)
        ],
      ),
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assests/bg2.png"), fit: BoxFit.cover),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 120.0),
          child: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: events.map((title) {
              return GestureDetector(
                child: Card(
                    margin: const EdgeInsets.all(20.0),
                    child: getCardByTitle(title)),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>  CharacterListingScreen()),
                  // Fluttertoast.showToast(
                  //   msg: title + "clicked",
                  //   toastLength: Toast.LENGTH_SHORT,
                  //   gravity: ToastGravity.BOTTOM,
                  //   backgroundColor: Colors.red,
                  //   textColor: Colors.white,
                  //   fontSize: 16.0,
                   );
                },
              );
            }).toList(),
          ),
        ),
      ),
    
    );
  }

  Column getCardByTitle(String title) {
    String img = "";
    if (title == "Scan")
      img = "assests/scanner.png";
    else if (title == "History")
      img = "assests/folder.png";
    else if (title == "Team")
      img = "assests/team.png";
    else if (title == "Info")
      img = "assests/info.png";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Center(
          child: Container(
              child: new Stack(
            children: <Widget>[
              new Image.asset(
                img,
                width: 80.0,
                height: 80.0,
              )
            ],
          )),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}