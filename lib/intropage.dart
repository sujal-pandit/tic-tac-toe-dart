import 'package:flutter/material.dart';
import 'package:tic_tac_toe_flutter/home_page.dart';
import 'package:tic_tac_toe_flutter/properties.dart';

class IntroPage extends StatefulWidget {
  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  var tapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage('assets/images/tic-tac-toe.png'),
              height: 200,
            ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
              onTap: () async {
                tapped = true;
                setState(() {});
                await (Future.delayed(Duration(milliseconds: 300)));
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              splashColor: Colors.transparent,
              child: tapped
                  ? TweenAnimationBuilder(
                      duration: Duration(milliseconds: 300),
                      tween: Tween<double>(begin: 70, end: 90),
                      builder: (BuildContext context, double _height,
                          Widget? child) {
                        return Center(
                          child: Image(
                            image: AssetImage("assets/images/button.png"),
                            height: _height,
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Image(
                        image: AssetImage("assets/images/button.png"),
                        height: 70,
                      ),
                    )),
        ],
      ),
    );
  }
}
