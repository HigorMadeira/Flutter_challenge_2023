import 'dart:math';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isEditable = false;
  String text = 'Hello there';
  TextEditingController textController =
      TextEditingController(text: 'Hello there');
  Color _backgroundColor = Colors.black;
  Color textColorBlack = const Color.fromRGBO(0, 0, 0, 1);
  Color textColorWhite = const Color.fromRGBO(255, 255, 255,
      1); //i will use this value to make a condition so the text will be always visible.

  @override
  void initState() {
    super.initState();
    _setRandomBackgroundColor();
  }

  void _setRandomBackgroundColor() {
    final Random random = Random();
    _backgroundColor = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
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
          'Radom colors',
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
            heroTag: "btn1",
            onPressed: () {
              setState(() {
                isEditable = !isEditable;
              });
            },
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0,
            child: const Icon(Icons.create_outlined),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              Navigator.of(context).pushNamed('/gradient');
            },
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0,
            child: const Icon(Icons.gradient_rounded),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "btnDisc",
            onPressed: () {
              Navigator.of(context).pushNamed('/dvd');
            },
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0,
            child: const Icon(Icons.disc_full),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "btnRainbow",
            onPressed: () {
              Navigator.of(context).pushNamed('/rainbow');
            },
            backgroundColor: Colors.white.withOpacity(0.4),
            elevation: 0,
            child: const Icon(Icons.color_lens_rounded),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            _setRandomBackgroundColor();
          });
        },
        child: Container(
          color: _backgroundColor,
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
                          color: (_backgroundColor == textColorBlack
                              ? textColorWhite
                              : textColorBlack),
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
