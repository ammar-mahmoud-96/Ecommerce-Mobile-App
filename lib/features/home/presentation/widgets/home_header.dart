import 'package:flutter/material.dart';
import 'package:flutter_app/core/constants/app_assets.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.onPrimary,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SHOP.CO',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              SizedBox(height: 20),
              Row(
                children: [
                  Text('Hello'),
                  SizedBox(width: 3),
                  Text('Ammar,', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),

              Text('Good morning'),
            ],
          ),
        ),
      ),
    );
  }
}
