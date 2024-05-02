import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({super.key, required this.colors, required this.icon});
  final List<Color> colors;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          shape: BoxShape.circle, gradient: RadialGradient(colors: colors)),
      child: Align(
        alignment: Alignment.center,
        child: Container(
            padding: const EdgeInsets.all(10),
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade600,
                      offset: const Offset(0, -4),
                      blurRadius: 100,
                      spreadRadius: 5,
                      blurStyle: BlurStyle.inner)
                ],
                //color: Colors.white,
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.grey.shade100,
                      Colors.grey.shade300,
                      Colors.grey.shade500,
                    ]),
                shape: BoxShape.circle),
            child: SvgPicture.asset(
              icon,
              fit: BoxFit.none,
            )),
      ),
    );
  }
}
