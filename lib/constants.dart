import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

//Background Color of Screens
Color kBackgroundColor = Colors.black;

//Heading Text Style
TextStyle kHeadingTextStyle =
    GoogleFonts.anton(color: Colors.amber, fontSize: 80);

//Hint text style for text fields
TextStyle kHintTextStyle =
    GoogleFonts.roboto(color: Colors.white60, fontStyle: FontStyle.italic);

//Button Color
Color kButtonColor = Colors.amber.shade700;

//Button Text Style

TextStyle kButtonTextStyle = GoogleFonts.roboto(
    color: Colors.grey.shade200, fontWeight: FontWeight.w400);

//Task Text Style
TextStyle kTaskTextStyle = GoogleFonts.robotoCondensed(color: Colors.white);

//DATES

final DateTime now = DateTime.now();
final String today =
    DateFormat("dd MMM").format(DateTime(now.year, now.month, now.day));
final String yesterday =
    DateFormat("dd MMM").format(DateTime(now.year, now.month, now.day - 1));
final String tomorrow =
    DateFormat("dd MMM").format(DateTime(now.year, now.month, now.day + 1));
