import 'package:flutter/material.dart';
import 'package:movierecommender/utils/color_utils.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: hexStringToColor("DDDEEB"),
  );
}

Container reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return Container( // Wrap in a Container
    width: 324,
    height: 58,
    child: TextField(
      controller: controller,
      obscureText: isPasswordType,
      enableSuggestions: !isPasswordType,
      autocorrect: !isPasswordType,
      cursorColor: hexStringToColor("DDDEEB"),
      style: TextStyle(color: Colors.white.withOpacity(0.9)),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: hexStringToColor("DDDEEB"),
        ),
        labelText: text,
        labelStyle: TextStyle(color: hexStringToColor("DDDEEB")),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        fillColor: hexStringToColor("121212"),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
      ),
      keyboardType: isPasswordType
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
    ),
  );
}


Container firebaseUIButton(BuildContext context, String title, Function onTap) {

  final buttonTextStyle = TextStyle(
    color: hexStringToColor("494F5A"),
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(22, 10, 22, 20),
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