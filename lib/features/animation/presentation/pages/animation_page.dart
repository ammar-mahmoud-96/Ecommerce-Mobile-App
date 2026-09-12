import 'package:flutter/material.dart';
import 'package:flutter_app/features/animation/presentation/pages/animated_builder_example.dart';
import 'package:flutter_app/features/animation/presentation/pages/foo_transition_animation_example.dart';
import 'package:flutter_app/features/animation/presentation/pages/animated_foo_animation_example.dart';
import 'package:flutter_app/features/animation/presentation/pages/tween_animation_example_page.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation Page')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'Implicit Animations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'what we did if all the AnimatedFoo widgets were not enough for our animation purpose? We used the  ',
                  ),
                  Text(
                    'TweenAnimationBuilder',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('to animate a property not covered in AnimatedFoo'),
                ],
              ),

              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnimatedFooExamplePage(),
                    ),
                  );
                },
                child: Text('Impicit animation with AnimatedFoo'),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TweenAnimationExample(),
                    ),
                  );
                },
                child: Text('Impicit animation with TweenAnimationBuilder'),
              ),
              SizedBox(height: 20),

              Text(
                'Explicit Animations',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                ' Similarly, in explicit animations, we can use the AnimatedBuilder widget to animate any and/or multiple widget properties',
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const FooTransitionAnimationExample(),
                    ),
                  );
                },
                child: Text('Explicit animation with FooTransition widgets'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(double.infinity, 60),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AnimatedBuilderExample(),
                    ),
                  );
                },
                child: Text('Explicit animation with AnimatedBuilder widget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
