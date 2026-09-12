import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_assets.dart';
import 'package:flutter_app/features/home/data/models/story_model.dart';
import 'package:flutter_svg/svg.dart';

class HomeStoryItem extends StatelessWidget {
  const HomeStoryItem({super.key, required this.story});

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(color: Theme.of(context).primaryColor, width: 2),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              story.icon ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              placeholderBuilder: (BuildContext context) =>
                  const CircularProgressIndicator(),
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.error),
            ),
          ),
        ),
        const SizedBox(height: 8),

        SizedBox(
          width: 70,
          child: Text(
            story.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
