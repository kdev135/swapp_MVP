import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// UI styles for the app
TextStyle titleStyle =
    GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600);

TextStyle productValueStyle = GoogleFonts.montserrat(
  fontSize: 15,
);

TextStyle productlabelStyle =
    GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500);
const InputDecoration inputDecoration = InputDecoration(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    hintText: '',


    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
    ));

TextStyle chipTextStyle = GoogleFonts.montserrat(
    fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87);
TextStyle watermarkStyle = GoogleFonts.montserrat(
    fontSize: 70,
    color: Colors.grey.shade400.withOpacity(0.2),
    fontWeight: FontWeight.w600);
