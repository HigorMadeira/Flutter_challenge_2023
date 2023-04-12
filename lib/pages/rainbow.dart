import 'dart:async';
import 'package:flutter/material.dart';

class Rainbow extends StatefulWidget {
  const Rainbow({
    Key? key,
  }) : super(key: key);

  @override
  State<Rainbow> createState() => _RainbowState();
}

class _RainbowState extends State<Rainbow> {
  bool isEditable = false;
  String text = 'Hello there';
  TextEditingController textController =
      TextEditingController(text: 'Hello there');
  Color textColorBlack = const Color.fromRGBO(0, 0, 0, 1);
  Color textColorWhite = const Color.fromRGBO(255, 255, 255, 1);
  int _colorIndex = 0;
  Timer? _timer;
  bool direction = true;
  int directionIndex = 0;

  final List<Color> _rainbowColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    // Colors.white,
    // Colors.pink,
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (_) {
      setState(() {
        _colorIndex = (_colorIndex + 1) % _rainbowColors.length;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 8,
        centerTitle: true,
        title: const Text(
          'Rainbow',
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
            heroTag: "btn6",
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
            heroTag: "btn7",
            onPressed: () {
              Navigator.pop(context);
            },
            backgroundColor: Colors.white.withOpacity(0.1),
            elevation: 1,
            child: const Icon(Icons.keyboard_backspace),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 50),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              _rainbowColors[_colorIndex],
              _rainbowColors[(_colorIndex + 1) % _rainbowColors.length],
            ],
            begin: direction ? Alignment.centerLeft : Alignment.centerRight,
            end: direction ? Alignment.centerRight : Alignment.centerLeft,
          ),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: directionIndex,
        onTap: (index) {
          if (index == 0) {
            direction = true;
          } else {
            direction = false;
          }
        },
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: 'Left',
            icon: Icon(Icons.arrow_left),
            backgroundColor: Colors.transparent,
          ),
          BottomNavigationBarItem(
            label: 'Right',
            icon: Icon(Icons.arrow_right),
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
