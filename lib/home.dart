import 'package:flutter/material.dart';
import 'package:flutter_progress_button_animation/done_animation.dart';
import 'package:flutter_progress_button_animation/hex_color.dart';
import 'package:flutter_progress_button_animation/phase_animation.dart';
import 'package:flutter_progress_button_animation/progress_button.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ProgressButtonState();
  }
}

class ProgressButtonState extends State<Home> {
  String buttonText = "START";
  PhaseAnimation phaseOne;
  PhaseAnimation phaseTwo;
  PhaseAnimation phaseThree;

  bool showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    phaseOne = new PhaseAnimation(HexColor("#A8F0FF"));
    phaseTwo = new PhaseAnimation(HexColor("#A8F0FF"));
    phaseThree = new PhaseAnimation(HexColor("#A8F0FF"));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Progress Button Animation App"),
        ),
        body: new Center(
          child: new ProgressButton(
              child: new Row(children: <Widget>[
                new Container(
                  margin: const EdgeInsets.only(left: 30.0, right: 85),
                  width: 100.0,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Visibility(
                  visible: !showCheckIcon,
                  child: new Row(
                    children: <Widget>[
                      phaseOne,
                      phaseTwo,
                      phaseThree,
                    ],
                  ),
                ),
                Visibility(visible: showCheckIcon, child: DoneAnimation())
              ]),
              onPressed: () async {
                phaseOne.run();
                setState(() {
                  buttonText = "PHASE 1";
                });
                await Future.delayed(const Duration(milliseconds: 2500));
                phaseTwo.run();
                setState(() {
                  buttonText = "PHASE 2";
                });
                phaseOne.stop();
                await Future.delayed(const Duration(milliseconds: 2500));
                phaseThree.run();
                setState(() {
                  buttonText = "PHASE 3";
                });
                phaseTwo.stop();
                await Future.delayed(const Duration(milliseconds: 2500));
                phaseThree.stop();

                phaseOne.move(2.0);
                phaseTwo.move(1.0);

                await Future.delayed(const Duration(milliseconds: 1000));
                setState(() {
                  showCheckIcon = true;
                  buttonText = "DONE!";
                });
              }),
        ));
  }
}
