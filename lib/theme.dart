import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kDark = Color(0xFF333333);
const kWhite = Color(0xFFFFFFFF);
const kBg = Color(0xFFF5F5F5);

TextStyle inter(
  double size, {
  FontWeight w = FontWeight.w400,
  Color c = kDark,
}) => GoogleFonts.inter(fontSize: size, fontWeight: w, color: c);

TextStyle playfair(
  double size, {
  FontWeight w = FontWeight.w600,
  Color c = kDark,
}) => GoogleFonts.playfairDisplay(fontSize: size, fontWeight: w, color: c);
