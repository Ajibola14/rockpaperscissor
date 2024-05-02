import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rock_paper_scissor/option_class.dart';
import 'package:rock_paper_scissor/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'optionWidget.dart';
import 'result_page.dart';
import 'score_board.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => RPS(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Homepage(),
      theme: ThemeData(fontFamily: "Barlow_Semi_Condensed"),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  Options choice = Options.rock;
  bool playing = true;

  @override
  Widget build(BuildContext context) {
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
                child: Stack(
                  children: [
                    Positioned(
                        left: 40,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              choice = Options.paper;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(choice),
                                ));
                          },
                          child: OptionWidget(colors: [
                            const HSLColor.fromAHSL(1, 230, 0.89, 0.62).toColor(),
                            const HSLColor.fromAHSL(1, 230, 0.89, 0.65).toColor()
                          ], icon: "images/icon-paper.svg"),
                        )),
                    Positioned(
                        right: 40,
                        child: GestureDetector(
                          onTap: () {
                          setState(() {
                            choice = Options.scissors;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(choice),
                              ));
                        },
                          child: OptionWidget(
                            colors: [
                              const HSLColor.fromAHSL(1, 39, 0.89, 0.49).toColor(),
                              const HSLColor.fromAHSL(1, 40, 0.84, 0.53).toColor()
                            ],
                            icon: "images/icon-scissors.svg",
                          ),
                        )),
                    Positioned(
                        top: 200,
                        left: 1,
                        right: 1,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              choice = Options.rock;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultPage(choice),
                                ));
                          },
                          child: OptionWidget(
                            colors: [
                              const HSLColor.fromAHSL(1, 349, 0.71, 0.52).toColor(),
                              const HSLColor.fromAHSL(1, 349, 0.70, 0.56).toColor()
                            ],
                            icon: "images/icon-rock.svg",
                          ),
                        )),
                  ],
                ),
              ),
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
                                color: const HSLColor.fromAHSL(1, 229, 0.25, 0.31)
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
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
