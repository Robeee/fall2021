import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled3/generated/i18n.dart';


class SelectLanguageScreen extends StatefulWidget {
  @override
  _SelectLanguageScreenState createState() => _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {
  var language;
  List<String> lang = [
    "English",
    "Arabic",
    "Chinese (Simplified)",
    "French",
    "Hindi",
    "Portuguese",
    "Spanish",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 20, 20),
          child: Text(
            "Please select your primary language.",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0.0, 22.0,275.0, 8.0),
          child: Text('Language',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            width: 385,
            height: 40,
            padding: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: DropdownButton(
              hint: Text(
                "Select Language",
                style: TextStyle(color: Colors.black, fontSize: 22),
              ),
              //icon: Icon(                // Add this
              //  Icons.arrow_drop_down_outlined,  // Add this
              //  color: Colors.blue,   // Add this
              //),
              icon: Image.asset(
                // Add this
                //Icons.arrow_drop_down_outlined, //size: 38.0,  // Add this
                "assets/images/dropdownarrow.png",
                width: 28,
                height: 18,
                //Icons.arrow_drop_down_outlined,
                //size: 31,
                color: Colors.blue, // Add this
              ),
              value: language,
              onChanged: (newLocale) {
                setState(() {
                  if (newLocale != null) {
                    language = newLocale;
                    I18n.onLocaleChanged!(language!);
                  }
                });
              },
              isExpanded: true,
              underline: SizedBox(),
              style: TextStyle(color: Colors.black, fontSize: 22),
              items: GeneratedLocalizationsDelegate()
                  .supportedLocales
                  .map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem,
                    child: Text((valueItem.languageCode)));
              }).toList(),
            ),
          ),
        ),],
    ));
  }
}