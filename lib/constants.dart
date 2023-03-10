import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//Background Color of Screens
Color kBackgroundColor = Colors.grey.shade900;

//Heading Text Style
TextStyle kHeadingTextStyle =
    GoogleFonts.anton(color: Colors.amber, fontSize: 80);

//Hint text style for text fields
TextStyle kHintTextStyle = GoogleFonts.roboto(
    color: Colors.white60, fontStyle: FontStyle.italic,
    //Leave this here. Even though it seems like it does nothing, it removes the shadow added somewhere else.
    shadows: <Shadow>[]);

//Button Color
Gradient kButtonColor =
    const LinearGradient(colors: [Colors.amber, Colors.amberAccent]);

//Button Text Style

TextStyle kButtonTextStyle = GoogleFonts.roboto(
    color: Colors.grey.shade200,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    shadows: <Shadow>[const Shadow(blurRadius: 0.5, color: Colors.black)]);

//Task Text Style
TextStyle kTaskTextStyle = GoogleFonts.robotoCondensed(
    color: Colors.white,
    shadows: <Shadow>[const Shadow(blurRadius: 0.5, color: Colors.black)],
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
