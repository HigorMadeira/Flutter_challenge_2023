import 'dart:math';
import 'package:flutter/material.dart';

class GradientColors extends StatefulWidget {
  const GradientColors({
    Key? key,
  }) : super(key: key);

  @override
  State<GradientColors> createState() => _GradientColorsState();
}

class _GradientColorsState extends State<GradientColors> {
  bool isEditable = false;
  String text = 'General Kenobi';
  TextEditingController textController =
      TextEditingController(text: 'General Kenobi');
  late Gradient _backgroundGradient;
  Color textColorBlack = const Color.fromRGBO(0, 0, 0, 1);
  Color textColorWhite = const Color.fromRGBO(255, 255, 255, 1);

  @override
  void initState() {
    super.initState();
    _setRandomBackgroundGradient();
  }

  void _setRandomBackgroundGradient() {
    final Random random = Random();
    final Color color1 = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    final Color color2 = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
    _backgroundGradient = LinearGradient(
      colors: [color1, color2],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: const Text(
          'Gradient Colors',
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(16),
          ),
        ),
        backgroundColor: Colors.white.withOpacity(0.6),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "btn3",
            onPressed: () {
              setState(() {
                isEditable = !isEditable;
              });
            },
            backgroundColor: Colors.white.withOpacity(0.1),
            elevation: 4,
            child: const Icon(Icons.create_outlined),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "btn4",
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.white.withOpacity(0.1),
            elevation: 1,
            child: const Icon(Icons.keyboard_backspace),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _setRandomBackgroundGradient();
          });
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: _backgroundGradient,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isEditable
                    ? TextFormField(
                        style: const TextStyle(fontSize: 25),
                        autofocus: true,
                        // initialValue: text,
                        controller: textController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        textAlign: TextAlign.center,
                        onFieldSubmitted: (value) {
                          setState(() {
                            text = value;
                            isEditable = false;
                          });
                        },
                      )
                    : Text(
                        text,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: textColorBlack,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
