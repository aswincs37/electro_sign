import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyButton extends StatelessWidget {
  final String? label;
  final Color? labelClr;
  final Color? btnClr;
  final Color? icnClr;
  final IconData? btnIcn;
  final VoidCallback buttonfunction;

  const BodyButton(
      {required this.label,
      required this.btnIcn,
      required this.icnClr,
      required this.labelClr,
      required this.btnClr,
      required this.buttonfunction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        btnIcn,
        color: icnClr,
      ),
      label: Text(
        label!,
        style: GoogleFonts.chakraPetch(
          textStyle: TextStyle(
            color: labelClr,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      onPressed: buttonfunction,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
          vertical: 20,
        ),
        backgroundColor: btnClr,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
