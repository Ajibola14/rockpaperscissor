import 'package:flutter/material.dart';
import 'package:rock_paper_scissor/provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard(this.value, {super.key});
  final RPS value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              width: 2,
              color: const HSLColor.fromAHSL(1, 217, 0.16, 0.45).toColor())),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ROCK",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              Text(
                "PAPER",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              Text(
                "SCISSORS",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(children: [
              Text(
                "SCORE",
                style: TextStyle(
                    letterSpacing: 1.5,
                    color: const HSLColor.fromAHSL(1, 229, 0.64, 0.46).toColor(),
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                value.score.toString(),
                style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                    color: Colors.black54),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
