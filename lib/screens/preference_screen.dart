import 'package:firebase_auth/firebase_auth.dart';
import 'package:movierecommender/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:movierecommender/utils/color_utils.dart';
import 'package:google_fonts/google_fonts.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({Key? key}) : super(key: key);

  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  String? selectedGenre; // Initialize with null to show placeholder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexStringToColor("232430"), // Set the AppBar background color
        iconTheme: IconThemeData(color: hexStringToColor("DDDEEB")), // Set the icon (back button) color
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) {
                print("Signed Out");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: hexStringToColor("232430"), // Set the background color of the Container
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter your movie preferences:", style: GoogleFonts.kadwa(
                    fontSize: 20,
                    color: hexStringToColor("DDDEEB"), 
                    letterSpacing: 1.100,
                    ),),
              SizedBox(height: 50), // Add some space between text and dropdown
              Container(
                width: 324, // Set the width
                height: 50, // Set the height
                margin: const EdgeInsets.fromLTRB(44, 10, 44, 20), // Set the margin
                child: DropdownButton<String>(
                  value: selectedGenre,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGenre = newValue;
                    });
                  },
                  hint: Text("Genre", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                  items: <String?>[null, 'Horror', 'Romance', 'Comedy']
                      .map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value ?? "Genre", style: TextStyle(color: hexStringToColor("DDDEEB"))),
                    );
                  }).toList(),
                ),
              ),
               textField("Enter actor:"),
              SizedBox(height: 15),
              textField("Enter year of release:"), 
              SizedBox(height: 15),
              SearchButton(context, "Search", (){}),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
    );
  }
}


Container textField(String text){
  return(
    Container(
      width: 324,
      height: 50,
      child: TextField(
        cursorColor: hexStringToColor("DDDEEB"),
        style: TextStyle(color: hexStringToColor("DDDEEB")),
        decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: hexStringToColor("DDDEEB")),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: hexStringToColor("121212"),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      )
  ));
}



Container SearchButton(BuildContext context, String title, Function onTap) {

  final buttonTextStyle = TextStyle(
    color: hexStringToColor("494F5A"),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(44, 10, 44, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: buttonTextStyle),

      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return hexStringToColor("DDDEEB");
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))),
    ),
  );
}