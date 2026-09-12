import 'package:flutter/material.dart';

class TweenAnimationExample extends StatelessWidget {
  const TweenAnimationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tween Animation Example')),
      body: Container(
        color: Colors.grey[200],
        width: double.infinity,
        height: 100,
        child: SizedBox(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 100),
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Center(
                child: Container(
                  height: value,
                  width: value,
                  color: Colors.blue,
                ),
              );
            },
            // child: Center(child: Text('Animating...')),
          ),
        ),
      ),
    );
  }
}
