import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BodyCard extends StatelessWidget {
  final String heading;
  final String subtxt;
  const BodyCard({required this.heading, required this.subtxt, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.all(20),
      child: SizedBox(
        height: 150,
        width: 300,
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.center,
              heading,
              style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              textAlign: TextAlign.center,
              subtxt,
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[900],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
