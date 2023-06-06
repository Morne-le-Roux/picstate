import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//Background Color of Screens
Color kBackgroundColor = Colors.white;

//Heading Text Style
TextStyle kHeadingTextStyle =
    GoogleFonts.anton(color: Colors.amber, fontSize: 80);

//Hint text style for text fields
TextStyle kHintTextStyle = GoogleFonts.roboto(
  color: Colors.grey,
  fontStyle: FontStyle.italic,
);

//Button Color
Gradient kButtonColor =
    const LinearGradient(colors: [Colors.amber, Colors.amberAccent]);

//Button Text Style

TextStyle kButtonTextStyle = GoogleFonts.roboto(
  color: Colors.black87,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.italic,
  // shadows: <Shadow>[const Shadow(blurRadius: 0.5, color: Colors.black)],
);

//Task Text Style
TextStyle kTaskTextStyle = GoogleFonts.robotoCondensed(
    color: const Color.fromARGB(255, 10, 10, 3),
    // shadows: <Shadow>[const Shadow(blurRadius: 0.5, color: Colors.black)],
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic);

//DATES

final DateTime now = DateTime.now();
final String today =
    DateFormat("dd MMM").format(DateTime(now.year, now.month, now.day));
final String yesterday =
    DateFormat("dd MMM").format(DateTime(now.year, now.month, now.day - 1));
final String tomorrow =
    DateFormat("dd MMM").format(DateTime(now.year, now.month, now.day + 1));

//Task Colors

const List<Color> kColorTodo = [Colors.amber, Colors.amberAccent];
const List<Color> kColorDone = [Colors.green, Colors.greenAccent];
const List<Color> kColorTodoToday = [
  Color.fromARGB(255, 255, 98, 0),
  Color.fromARGB(255, 255, 144, 64)
];
