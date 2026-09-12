import 'package:flutter/material.dart';

class FooTransitionAnimationExample extends StatefulWidget {
  const FooTransitionAnimationExample({super.key});

  @override
  State<FooTransitionAnimationExample> createState() =>
      _FooTransitionAnimationExampleState();
}

class _FooTransitionAnimationExampleState
    extends State<FooTransitionAnimationExample>
    with TickerProviderStateMixin {
  late AnimationController rotationController;
  late Animation<double> rotationAnimation;

  late AnimationController alignController;
  late Animation<Alignment> alignAnimation;

  @override
  dispose() {
    rotationController.dispose();
    alignController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    //// Rotation Animation
    rotationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    // ..repeat();
    rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(rotationController);
    // rotationController.forward();

    //// Alignment Animation
    alignController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    alignAnimation =
        AlignmentTween(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ).animate(
          CurvedAnimation(parent: alignController, curve: Curves.easeInOut),
        );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foo Transition Animation Example')),
      body: Center(
        child: Container(
          height: 70,
          width: double.infinity,
          color: Colors.grey[300],
          child: AlignTransition(
            alignment: alignAnimation,
            child: RotationTransition(
              turns: rotationAnimation,
              child: Container(color: Colors.red, width: 50, height: 50),
            ),
          ),
        ),
      ),
    );
  }
}



// Other FooTransition Animations include:
// AlignTransition

// DecoratedBoxTransition

// DefaultTextStyleTransition

// FadeTransition

// PositionedTransition

// RelativePositionedTransition

// RotationTransition

// ScaleTransition

// ScaleTransition

// SizeTransition

// SlideTransition

// StatusTransitionWidget