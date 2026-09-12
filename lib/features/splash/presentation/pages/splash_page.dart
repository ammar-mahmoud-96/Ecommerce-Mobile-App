import 'package:flutter/material.dart';
import 'package:flutter_app/core/l10n/app_localizations.dart';
import 'package:flutter_app/features/main/presentation/pages/main_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Animation<double> logoAnimation;
  late AnimationController logoController;

  late Animation<double> fadeAnimation;
  late AnimationController fadeController;
  bool logoAnimationEnded = false;

  @override
  void initState() {
    super.initState();

    logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: fadeController, curve: Curves.easeIn));

    logoAnimation = Tween<double>(begin: 0, end: 300).animate(logoController)
      ..addListener(() {
        setState(() {});
        if (logoAnimation.status == AnimationStatus.completed) {
          setState(() {
            logoAnimationEnded = true;
          });
          fadeController.forward();
        }
      });

    logoController.forward();
  }

  @override
  void dispose() {
    logoController.dispose();
    fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final translate = AppLocalizations.of(context)!.translate;

    return !logoAnimationEnded
        ? Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 100),
                height: logoAnimation.value,
                width: logoAnimation.value,
                child: const FlutterLogo(),
              ),
            ),
          )
        : FadeTransition(
            opacity: fadeAnimation,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/splash.png',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        translate('splashTitle'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        translate('splashTitle'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: 279,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                            );
                          },
                          child: Text(
                            translate('getStarted'),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      SizedBox(height: 40),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
