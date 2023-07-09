import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/properties.dart';

import 'intropage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> displayXO = ['', '', '', '', '', '', '', '', ''];
  late bool xTurn;
  Random random = Random();
  int xWins = 0, oWins = 0;

  @override
  void initState() {
    super.initState();
    xTurn = random.nextInt(2) == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => IntroPage()));
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.grey,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "X Wins",
                      style: TextStyle(color: xColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      xWins.toString(),
                      style: TextStyle(color: xColor, fontSize: 20),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "O Wins",
                      style: TextStyle(color: oColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      oWins.toString(),
                      style: TextStyle(color: oColor, fontSize: 20),
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: xTurn == true
                  ? Text(
                      "Player X Turn",
                      style: TextStyle(color: xColor, fontSize: 20),
                    )
                  : Text(
                      "PLayer O Turn",
                      style: TextStyle(color: oColor, fontSize: 20),
                    ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      gameplay(index);
                    },
                    child: Container(
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: boxColor,
                          boxShadow: [
                            BoxShadow(
                                color: displayXO[index] == ''
                                    ? Colors.grey.shade800
                                    : (displayXO[index] == "X"
                                        ? xColor
                                        : oColor),
                                spreadRadius: 0.1,
                                blurRadius: 2.0)
                          ],
                          border: Border.all(
                              color: displayXO[index] == ''
                                  ? Colors.grey.shade800
                                  : (displayXO[index] == "X"
                                      ? xColor
                                      : oColor))),
                      child: Center(
                          child: Text(
                        displayXO[index],
                        style: TextStyle(
                            color: displayXO[index] == "X" ? xColor : oColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: ElevatedButton(
              onPressed: () {
                xWins = 0;
                oWins = 0;
                setState(() {});
              },
              child: Text(
                "Reset Wins",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  fixedSize: Size(220, 60)),
            ),
          )
        ],
      ),
    );
  }

  void gameplay(int index) {
    if (xTurn == true && displayXO[index] == "") {
      displayXO[index] = "X";
    } else if (xTurn == false && displayXO[index] == "") {
      displayXO[index] = "O";
    }
    xTurn = !xTurn;
    setState(() {});
    checkWinner();
  }

  void checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      showWinner(displayXO[0]);
    } else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      showWinner(displayXO[3]);
    } else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      showWinner(displayXO[6]);
    } else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      showWinner(displayXO[0]);
    } else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      showWinner(displayXO[1]);
    } else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      showWinner(displayXO[2]);
    } else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      showWinner(displayXO[0]);
    } else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      showWinner(displayXO[2]);
    } else if (displayXO.contains('') == false) {
      drawDialog();
    }
  }

  void showWinner(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Player ${winner} is the winner"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: winner == "X" ? xColor : oColor),
                  onPressed: () {
                    winner == "X" ? xWins += 1 : oWins += 1;
                    clearBoard();
                  },
                  child: Text(
                    "Play Again!",
                  ))
            ],
          );
        });
  }

  void clearBoard() {
    Navigator.pop(context);
    setState(() {
      displayXO = ['', '', '', '', '', '', '', '', ''];
      xTurn = random.nextInt(2) == 1 ? true : false;
    });
  }

  void drawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("The Game is Draw"),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: boxColor),
                  onPressed: () {
                    clearBoard();
                  },
                  child: Text(
                    "Play Again!",
                  ))
            ],
          );
        });
  }
}
