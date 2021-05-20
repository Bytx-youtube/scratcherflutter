import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';

class ScratchScreen extends StatefulWidget {
  @override
  _ScratchScreenState createState() => _ScratchScreenState();
}

class _ScratchScreenState extends State<ScratchScreen> {
  final scratchKey = GlobalKey<ScratcherState>();
  bool _enabled = true;
  bool _reveal = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Scratcher(
              key: scratchKey,
              enabled: _enabled,
              brushSize: 30,
              image: Image(image: AssetImage('images/image.png'),),
              accuracy: ScratchAccuracy.low,
              threshold: 70,
              onThreshold: () {
                print("THRESHOLD REACHED!!");
                setState(() {
                  _enabled = false;
                });
              },
              onChange: (value) {
                if(value > 0.1) {
                  print(value);
                }

                if(value > 50) {
                  setState(() {
                    _reveal = true;
                  });
                }
              },
              child: Container(
                height: 200,
                width: 200,
                color: Colors.black,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _reveal ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 500),
                    child: Text(
                      "PRIZE", style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                scratchKey.currentState.reset(duration: Duration(milliseconds: 500));
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "GET A NEW CARD"
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                scratchKey.currentState.reveal(duration: Duration(milliseconds: 500));
              },
              child: Container(
                height: 40,
                width: 200,
                color: Colors.red,
                child: Center(
                  child: Text(
                    "REVEAL CARD",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
