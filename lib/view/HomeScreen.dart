import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'GameScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/green_background.jpg'),
          fit: BoxFit.cover),
          ),
          child: Column(
          children: [
            SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: Center(
                child: Column( // Column imbriquée pour "BLACKJACK" et "GAME"
                  mainAxisAlignment: MainAxisAlignment.center,
                  // Centre verticalement
                  children: [
                    Text(
                      "BLACKJACK", style: GoogleFonts.fanwoodText(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                    ),
                    Text(
                        "GAME", style: GoogleFonts.fanwoodText(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (context) => const GameScreen(title: 'Game Screen')));
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black87),
                ),
                child: const Text(
                  "New Game",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}