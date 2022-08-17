import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;

  final Animation<double> opacity;
  final Animation<double> width;
  final Animation<double> height;
  final Animation<EdgeInsets> padding;

  final Animation<BorderRadius?> borderRadius;
  final Animation<Color?> color;

  StaggerAnimation({Key? key, required this.controller})
      : opacity = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.0,
              0.100,
              curve: Curves.ease,
            ),
          ),
        ),
        width = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.125,
              0.250,
              curve: Curves.ease,
            ),
          ),
        ),
        height = Tween<double>(
          begin: 50.0,
          end: 150.0,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.150,
              0.350,
              curve: Curves.ease,
            ),
          ),
        ),
        padding = Tween<EdgeInsets>(
          begin: const EdgeInsets.all(15.0),
          end: const EdgeInsets.all(50.0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.350,
              0.550,
              curve: Curves.ease,
            ),
          ),
        ),
        borderRadius = BorderRadiusTween(
          begin: BorderRadius.circular(0),
          end: BorderRadius.circular(100),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.1,
              0.900,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.blue,
          end: Colors.orange,
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.500,
              0.900,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            padding: padding.value,
            child: Opacity(
              opacity: opacity.value,
              child: Container(
                width: width.value,
                height: height.value,
                decoration: BoxDecoration(
                  color: color.value,
                  border: Border.all(
                    color: Colors.indigo,
                    width: 3.0,
                  ),
                  borderRadius: borderRadius.value,
                ),
              ),
            ),
          );
        });
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: _playAnimation,
          child: const Icon(Icons.play_arrow),
        ),
        appBar: AppBar(
          title: const Text('Staggered Animation'),
        ),
        body: Center(
          child: StaggerAnimation(controller: _controller),
        ),
      ),
    );
  }
}
