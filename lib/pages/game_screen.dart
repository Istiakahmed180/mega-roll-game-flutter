import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List diceList = [
    "assets/d1.png",
    "assets/d2.png",
    "assets/d3.png",
    "assets/d4.png",
    "assets/d5.png",
    "assets/d6.png"
  ];

  int index1 = 0;
  int index2 = 0;
  int diceSum = 0;
  int target = 0;
  String result = "";
  bool hasResult = false;
  bool hasTarget = false;
  final random = Random.secure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(diceList[index1], width: 100, height: 100),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      diceList[index2],
                      width: 100,
                      height: 100,
                    )
                  ],
                ),
                Text(
                  "Dice Sum: $diceSum",
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (hasTarget)
                  Text(
                    "Your Target Is: $target",
                    style: const TextStyle(fontSize: 20, color: Colors.purple),
                  ),
              ],
            ),
            if (result.isNotEmpty)
              Text(
                result,
                style: TextStyle(
                    fontSize: 50,
                    color: result == "YOU WIN!!!" ? Colors.green : Colors.red),
              ),
            Column(
              children: [
                if (hasTarget)
                  Text(
                    "Rolling To Match: $target",
                    style:
                        const TextStyle(fontSize: 20, color: Colors.deepOrange),
                  ),
                const SizedBox(
                  height: 10,
                ),
                if (result.isEmpty)
                  DiceButton(level: "Roll", onPressed: diceRoll),
                if (result.isNotEmpty)
                  DiceButton(level: "Reset", onPressed: diceReset)
              ],
            )
          ],
        ),
      ),
    );
  }

  void diceRoll() {
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      diceSum = index1 + index2 + 2;
      if (hasTarget) {
        targetMatchMethod();
      } else {
        diceWinOrLost();
      }
    });
  }

  void diceWinOrLost() {
    diceWinOrLostMethod();
  }

  void diceWinOrLostMethod() {
    if (diceSum == 7 || diceSum == 11) {
      hasTarget = false;
      result = "YOU WIN!!!";
    } else if (diceSum == 2 || diceSum == 3 || diceSum == 12) {
      hasTarget = false;
      result = "YOU LOST!!!";
    } else {
      result = "";
      target = diceSum;
      hasTarget = true;
    }
  }

  void diceReset() {
    setState(() {
      index1 = 0;
      index2 = 0;
      diceSum = 0;
      result = "";
      hasResult = false;
    });
  }

  void targetMatchMethod() {
    if (diceSum == target) {
      hasTarget = false;
      result = "YOU WIN!!!";
    } else if (diceSum == 7) {
      hasTarget = false;
      result = "YOU LOST!!!";
    }
  }
}

class DiceButton extends StatelessWidget {
  final String level;
  final VoidCallback onPressed;

  const DiceButton({super.key, required this.level, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 50,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
          onPressed: onPressed,
          child: Text(
            level.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )),
    );
  }
}
