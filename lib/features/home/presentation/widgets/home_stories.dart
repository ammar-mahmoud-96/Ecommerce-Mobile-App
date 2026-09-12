import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/constants.dart';
import 'package:flutter_app/features/home/presentation/widgets/home_story_item.dart';

class HomeStories extends StatelessWidget {
  const HomeStories({super.key, required this.context});

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -34),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: Transform.translate(
          offset: const Offset(0, -38),
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: storiesList.map((story) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: HomeStoryItem(story: story),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
