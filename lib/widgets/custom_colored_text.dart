// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomColoredText extends StatelessWidget {
  var text;
  String hexColor;
  var size;
  var weight;
  CustomColoredText({
    Key? key,
    required this.text,
    required this.hexColor,
    required this.size,
    required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      softWrap: true,
      style: GoogleFonts.dmSans(
        textStyle: TextStyle(
          color: HexColor(hexColor),
          fontSize: size - 0.01,
          fontWeight: (weight == 500)
              ? FontWeight.w500
              : (weight == 400)
                  ? FontWeight.w400
                  : FontWeight.w300,
        ),
      ),
    );
  }
}
