import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rock_paper_scissor/main.dart';
import 'package:rock_paper_scissor/optionWidget.dart';
import 'package:rock_paper_scissor/option_class.dart';
import 'provider.dart';
import 'score_board.dart';
import 'dart:math';

class ResultPage extends StatefulWidget {
  const ResultPage(this.choice, {super.key});
  final Options choice;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late final Future gettingResult;
  bool _ready = false;

  String verdict = "";

  List<Color> compColors = [];

  String compIcon = "";

  Future getCompChoice() async {
    int random = Random().nextInt(3);
    Options compOpt = Options.values[random];
    compIcon = compOpt.name;

    if (compOpt == Options.paper) {
      compColors = [
        const HSLColor.fromAHSL(1, 230, 0.89, 0.62).toColor(),
        const HSLColor.fromAHSL(1, 230, 0.89, 0.65).toColor()
      ];
    } else if (compOpt == Options.scissors) {
      compColors = [
        const HSLColor.fromAHSL(1, 39, 0.89, 0.49).toColor(),
        const HSLColor.fromAHSL(1, 40, 0.84, 0.53).toColor()
      ];
    } else {
      compColors = [
        const HSLColor.fromAHSL(1, 349, 0.71, 0.52).toColor(),
        const HSLColor.fromAHSL(1, 349, 0.70, 0.56).toColor()
      ];
    }
    await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
    checkWinner(compOpt);
  }

  @override
  void initState() {
    super.initState();
    gettingResult = getCompChoice();
  }

  void checkWinner(Options compOpt) {
    if (compOpt.name == widget.choice.name) {
      setState(() {
        verdict = "DRAW";
        _ready = true;
      });
    } else if (compOpt == Options.scissors && widget.choice == Options.paper) {
      loseCase();
    } else if (compOpt == Options.scissors && widget.choice == Options.rock) {
      winCase();
    } else if (compOpt == Options.paper && widget.choice == Options.scissors) {
      winCase();
    } else if (compOpt == Options.paper && widget.choice == Options.rock) {
      loseCase();
    } else if (compOpt == Options.rock && widget.choice == Options.scissors) {
      loseCase();
    } else if (compOpt == Options.rock && widget.choice == Options.paper) {
      winCase();
    }
  }

  void winCase() {
    Provider.of<RPS>(context, listen: false).updateScore();
    setState(() {
      verdict = "YOU WIN";
      _ready = true;
    });
  }

  void loseCase() {
    setState(() {
      verdict = "YOU LOSE";
      _ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> colors;
    if (widget.choice == Options.paper) {
      colors = [
        const HSLColor.fromAHSL(1, 230, 0.89, 0.62).toColor(),
        const HSLColor.fromAHSL(1, 230, 0.89, 0.65).toColor()
      ];
    } else if (widget.choice == Options.scissors) {
      colors = [
        const HSLColor.fromAHSL(1, 39, 0.89, 0.49).toColor(),
        const HSLColor.fromAHSL(1, 40, 0.84, 0.53).toColor()
      ];
    } else {
      colors = [
        const HSLColor.fromAHSL(1, 349, 0.71, 0.52).toColor(),
        const HSLColor.fromAHSL(1, 349, 0.70, 0.56).toColor()
      ];
    }
    return Consumer<RPS>(
      builder: (context, value, child) => Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                const HSLColor.fromAHSL(1, 214, 0.47, 0.23).toColor(),
                const HSLColor.fromAHSL(1, 237, 0.49, 0.15).toColor()
              ])),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              ScoreBoard(value),
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OptionWidget(
                            colors: colors,
                            icon: "images/icon-${widget.choice.name}.svg"),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "YOU PICKED",
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder(
                          future: gettingResult,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                    radius: 65,
                                    backgroundColor: const HSLColor.fromAHSL(
                                            1, 229, 0.25, 0.31)
                                        .toColor()),
                              );
                            } else {
                              return OptionWidget(
                                  colors: compColors,
                                  icon: "images/icon-$compIcon.svg");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "THE HOUSE PICKED",
                          style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                  visible: _ready,
                  child: Column(
                    children: [
                      Text(
                        verdict,
                        style: const TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 50,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Homepage(),
                              ));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            "PLAY AGAIN",
                            style: TextStyle(
                                letterSpacing: 1.5,
                                color:
                                    const HSLColor.fromAHSL(1, 229, 0.25, 0.31)
                                        .toColor(),
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog.fullscreen(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "RULES",
                            style: TextStyle(
                                letterSpacing: 1.2,
                                color:
                                    const HSLColor.fromAHSL(1, 229, 0.25, 0.31)
                                        .toColor(),
                                fontWeight: FontWeight.w700,
                                fontSize: 35),
                          ),
                          SvgPicture.asset("images/image-rules.svg"),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SvgPicture.asset("images/icon-close.svg"),
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)),
                  child: const Text(
                    "RULES",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 3,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
