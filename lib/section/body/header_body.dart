import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header_body extends StatelessWidget {
  const Header_body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage("assets/images/orginalBg.jpg"),
              ),
            ),
            height: 500,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: "Maximize Your Efficiency with",
                        style: GoogleFonts.dancingScript(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        text: " ElectroSign",
                        style: GoogleFonts.dancingScript(
                            fontSize: 55,
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w600))
                  ])),
                  const SizedBox(height: 20),
                  Text(
                    "Welcome back! With more products and features, you can improve workflows,\n"
                    "simplify business and add extra levels of security.",
                    style: GoogleFonts.caveat(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(right: 200),
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.create,
                        color: Colors.black,
                      ),
                      label: Text(
                        "Explore",
                        style: GoogleFonts.chakraPetch(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // Your button action here
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 40,
                          vertical: 20,
                        ),
                        backgroundColor: Color.fromARGB(255, 4, 197, 211),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}