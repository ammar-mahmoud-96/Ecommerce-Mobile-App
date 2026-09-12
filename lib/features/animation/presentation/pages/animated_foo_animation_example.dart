import 'package:flutter/material.dart';

class AnimatedFooExamplePage extends StatefulWidget {
  const AnimatedFooExamplePage({super.key});
  final List<String> items = const [
    'Text1',
    'Text2',
    'Text3',
    'Text4',
    'Text5',
  ];

  @override
  State<AnimatedFooExamplePage> createState() => _AnimatedFooExamplePageState();
}

class _AnimatedFooExamplePageState extends State<AnimatedFooExamplePage> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AnimatedFoo Example')),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 220,
              width: double.infinity,
              child: ListView.builder(
                itemCount: widget.items.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                      color: selectedIndex == index
                          ? Colors.amber
                          : Colors.amber[100],
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.items[index]),
                          if (index == 2)
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              color: selectedIndex == index
                                  ? Colors.indigoAccent[100]
                                  : Colors.transparent,
                              alignment: Alignment.center,
                              width: 100,
                              height: 30,
                              child: AnimatedDefaultTextStyle(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                style: TextStyle(
                                  color: selectedIndex == index
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                child: Text('Top Seller'),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              child: AnimatedRotation(
                turns: 6,
                duration: Duration(seconds: 100),
                child: Container(color: Colors.red, width: 50, height: 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// other AnimatedFoo widgets:
/// 
/// AnimatedAlign

// AnimatedContainer

// AnimatedDefaultTextStyle

// AnimatedOpacity

// AnimatedPadding

// AnimatedPhysicalModel

// AnimatedPositioned

// AnimatedPositionDirectional

// AnimatedSize