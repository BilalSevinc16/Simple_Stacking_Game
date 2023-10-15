import 'dart:async';

import 'package:flutter/material.dart';
import 'package:simple_stacking_game/button.dart';
import 'package:simple_stacking_game/pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 130;
  List<int> piece = [];
  var direction = "left";
  List<int> landed = [100000];
  int level = 0;

  void startGame() {
    piece = [
      numberOfSquares - 3 - level * 10,
      numberOfSquares - 2 - level * 10,
      numberOfSquares - 1 - level * 10,
    ];
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (checkWinner()) {
        _showDialog();
        timer.cancel();
      }
      if (piece.first % 10 == 0) {
        direction = "right";
      } else if (piece.last % 10 == 9) {
        direction = "left";
      }
      setState(() {
        if (direction == "right") {
          for (int i = 0; i < piece.length; i++) {
            piece[i] += 1;
          }
        } else {
          for (int i = 0; i < piece.length; i++) {
            piece[i] -= 1;
          }
        }
      });
    });
  }

  bool checkWinner() {
    if (landed.last < 10) {
      return true;
    } else {
      return false;
    }
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Winner!"),
          );
        });
  }

  void stack() {
    level++;
    setState(() {
      for (int i = 0; i < piece.length; i++) {
        landed.add(piece[i]);
      }
      if (level < 4) {
        piece = [
          numberOfSquares - 3 - level * 10,
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10,
        ];
      } else if (level >= 4 && level < 8) {
        piece = [
          numberOfSquares - 2 - level * 10,
          numberOfSquares - 1 - level * 10,
        ];
      } else if (level >= 8) {
        piece = [
          numberOfSquares - 1 - level * 10,
        ];
      }
      checkStack();
    });
  }

  void checkStack() {
    setState(() {
      for (int i = 0; i < landed.length; i++) {
        if (!landed.contains(landed[i] + 10) &&
            (landed[i] + 10) < numberOfSquares - 1) {
          landed.remove(landed[i]);
        }
      }
      for (int i = 0; i < landed.length; i++) {
        if (!landed.contains(landed[i] + 10) &&
            (landed[i] + 10) < numberOfSquares - 1) {
          landed.remove(landed[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: Column(
          children: [
            Expanded(
              flex: 5,
              child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (piece.contains(index)) {
                    return const MyPixel(
                      color: Colors.white,
                    );
                  } else if (landed.contains(index)) {
                    return const MyPixel(
                      color: Colors.white,
                    );
                  } else {
                    return const MyPixel(
                      color: Colors.black,
                    );
                  }
                },
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    function: startGame,
                    child: const Text(
                      "P L A Y",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  MyButton(
                    function: stack,
                    child: const Text(
                      "S T O P",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
