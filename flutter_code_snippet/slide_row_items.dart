import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  List<Animation<Offset>>? _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _offsetAnimation = List.generate(
      2,
          (index) => Tween<Offset>(
        begin: const Offset(0.0, 0.0),
        end: Offset(index == 0 ? 1 : -1, 0.0),
      ).animate(_controller!),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  void _animate() {
    _controller!.status == AnimationStatus.completed
        ? _controller!.reverse()
        : _controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Demo Row Animation")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BoxWidget(
                  callBack: _animate,
                  text: "1",
                  color: Colors.red,
                  position: _offsetAnimation![0],
                ),
                BoxWidget(
                  callBack: _animate,
                  text: "2",
                  color: Colors.blue,
                  position: _offsetAnimation![1],
                )
              ],
            ),
            GestureDetector(
              onTap: _animate,
              child: const Text("Swap"),
            )
          ],
        ),
      ),
    );
  }
}

class BoxWidget extends StatelessWidget {
  final Animation<Offset> position;
  final Function callBack;
  final String text;
  final Color color;

  const BoxWidget(
      {Key? key, required this.position,required this.callBack,required this.text,required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: position,
      child: GestureDetector(
        onTap: () => callBack(),
        child: Container(
          margin: const EdgeInsets.all(10),
          height: 50,
          width: 50,
          color: color,
          child: Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Center(child: Text(text)),
            ),
          ),
        ),
      ),
    );
  }
}
