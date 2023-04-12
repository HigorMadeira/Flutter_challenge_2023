import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class DvdLogo extends StatefulWidget {
  const DvdLogo({
    super.key,
  });

  @override
  State<DvdLogo> createState() => _DvdLogoState();
}

class _DvdLogoState extends State<DvdLogo> {
  bool isEditable = false;
  String text = 'Hello there';
  TextEditingController textController =
      TextEditingController(text: 'Hello there');
  Color _backgroundColor = Colors.black;
  Color textColorBlack = const Color.fromRGBO(0, 0, 0, 1);
  Color textColorWhite = const Color.fromRGBO(255, 255, 255, 1);
  Timer? timer;
  Random random = Random();

  Color dvdColor = Colors.pink;
  double dvdWidth = 150, dvdHeight = 100;
  double x = 90, y = 30, xSpeed = 50, ySpeed = 50, speed = 150;

  _setRandomBackgroundColor() {
    Timer(
      const Duration(milliseconds: 100),
      () {
        int r = random.nextInt(255);
        int g = random.nextInt(255);
        int b = random.nextInt(255);
        _backgroundColor = Color.fromRGBO(r, g, b, 1);
      },
    );
  }

  @override
  initState() {
    super.initState();

    _setRandomBackgroundColor();
    update();
  }

  update() {
    timer = Timer.periodic(Duration(milliseconds: speed.toInt()), (timer) {
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;
      x += xSpeed;
      y += ySpeed;

      if (x + dvdWidth >= screenWidth) {
        xSpeed = -xSpeed;
        x = screenWidth - dvdWidth;
        _setRandomBackgroundColor();
      } else if (x <= 0) {
        xSpeed = -xSpeed;
        x = 0;
        _setRandomBackgroundColor();
      }

      if (y + dvdHeight >= screenHeight) {
        ySpeed = -ySpeed;
        y = screenHeight - dvdHeight;
        _setRandomBackgroundColor();
      } else if (y <= 0) {
        ySpeed = -ySpeed;
        y = 0;
        _setRandomBackgroundColor();
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: const Text(
          'DVD',
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.2),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "DVDback",
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.white.withOpacity(0.1),
            elevation: 1,
            child: const Icon(Icons.keyboard_backspace),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: speed.toInt()),
            left: x,
            top: y,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: (_backgroundColor == textColorBlack
                    ? textColorWhite
                    : textColorBlack),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
