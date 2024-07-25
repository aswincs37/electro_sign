import 'package:electrosign/widgets/body_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstMiddleBody extends StatelessWidget {
  const FirstMiddleBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Go paperless with ",
                      style: GoogleFonts.acme(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: "E",
                      style: GoogleFonts.acme(
                          fontSize: 55,
                          color: Colors.red,
                          fontWeight: FontWeight.w600)),
                  TextSpan(
                      text: " lectroSign",
                      style: GoogleFonts.acme(
                          fontSize: 55,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w600))
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BodyCard(
                  heading: "Become more agile",
                  subtxt:
                      "Business moves fast, and today’s customers expect convenience. \nWe can help you power your digital transformation."),
              BodyCard(
                  heading: "Save time and money",
                  subtxt:
                      "Get your contracts signed faster to keep \tyour business moving."),
              BodyCard(
                  heading: "Reduce your environmental impact",
                  subtxt:
                      "Shift to digital agreement processes to \nsave paper, water and waste")
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  "Integrations for every workflow",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.grey[900],
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    textAlign: TextAlign.center,
                    "Streamline your workflows with connected integrations—more than 900\n of them. Wherever you need contracts to work, they do.",
                    style: TextStyle(fontSize: 18, color: Colors.grey[900]))
              ],
            ),
          )
        ],
      ),
    );
  }
}
