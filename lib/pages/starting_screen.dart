import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mega_roll/pages/game_screen.dart';

const gameRules = '''
* AT THE FIRST ROLL, IF THE DICE SUM IS 7 OR 11, YOU WIN!
* AT THE FIRST ROLL, IF THE DICE SUM IS 2, 3 OR 12, YOU LOST!!
* AT THE FIRST ROLL, IF THE DICE SUM IS 4, 5, 6, 8, 9, 10, THEN THIS DICE SUM WILL BE YOUR TARGET POINT, AND KEEP ROLLING
* IF THE DICE SUM MATCHES YOUR TARGET POINT, YOU WIN!
* IF THE DICE SUM IS 7, YOU LOST!!
''';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});

  @override
  State<StartingScreen> createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  bool startRoll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE41A23),
        centerTitle: true,
        title: Text(
          "Megaroll".toUpperCase(),
          style:
          const TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50, top: 50),
          child: startRoll
              ? const GameScreen()
              : Column(
            children: [
              Image.asset(
                "assets/dicelogo.png",
                width: 200,
                height: 200,
              ),
              RichText(
                  text: TextSpan(
                      text: "Mega".toUpperCase(),
                      style: GoogleFonts.russoOne(textStyle: const TextStyle(
                          fontSize: 30,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold)),
                      children: [
                        TextSpan(
                            text: "Roll".toUpperCase(),
                            style: const TextStyle(color: Colors.black))
                      ])),
              const Spacer(),
              Padding(
                  padding: const EdgeInsets.all(5),
                  child:
                  StartDiceButton(level: "Start", OnStart: OnStart)),
              Padding(
                padding: const EdgeInsets.all(5),
                child: StartDiceButton(
                    level: "How To Play",
                    OnStart: () {
                      showInstruction(context);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void OnStart() {
    setState(() {
      startRoll = true;
    });
  }

  void showInstruction(BuildContext context) {
    showDialog(context: context, builder: (context) =>
        AlertDialog(
          title: Text("Instruction".toUpperCase()),
          content: const Text(gameRules,textAlign: TextAlign.justify,),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Close".toUpperCase()))
          ],
        ));
  }
}

class StartDiceButton extends StatelessWidget {
  final String level;
  final VoidCallback OnStart;

  const StartDiceButton(
      {super.key, required this.level, required this.OnStart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 190,
      height: 50,
      child: ElevatedButton(
          onPressed: OnStart,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          child: Text(
            level.toUpperCase(),
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}
