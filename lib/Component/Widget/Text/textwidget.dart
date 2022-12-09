import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
      {Key? key,
      this.title,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign})
      : super(key: key);

  final String? title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? 'Unknown',
      style: GoogleFonts.poppins(
          color: color ?? Colors.black,
          fontSize: fontSize ?? 12,
          fontWeight: fontWeight ?? FontWeight.w400),
      textAlign: textAlign ?? TextAlign.start,
    );
  }
}
