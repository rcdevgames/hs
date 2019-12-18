import 'package:flutter/material.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class WelcomePage extends StatelessWidget {
  List<Slide> slides = new List();

  @override
  Widget build(BuildContext context) {
    slides.add(
      new Slide(
        centerWidget: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset("assets/Images/logo.png"),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/Images/01.png"),
              )
            ],
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
    );
    slides.add(
      new Slide(
        centerWidget: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset("assets/Images/logo.png"),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/Images/02.png"),
              )
            ],
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
    );
    slides.add(
      new Slide(
        centerWidget: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Image.asset("assets/Images/logo.png"),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset("assets/Images/03.png"),
              )
            ],
          ),
        ),
        backgroundColor: Theme.of(context).canvasColor,
      ),
    );

    return IntroSlider(
      slides: this.slides,
      onDonePress: () => navService.navigateReplaceTo("/main"),
      nameSkipBtn: allTranslations.text("SKIP"),
      nameNextBtn: allTranslations.text("NEXT"),
      nameDoneBtn: allTranslations.text("DONE"),
      styleNameSkipBtn: TextStyle(color: Theme.of(context).primaryColor),
      styleNameDoneBtn: TextStyle(color: Theme.of(context).primaryColor),
      styleNamePrevBtn: TextStyle(color: Theme.of(context).primaryColor),
      colorDot: Theme.of(context).primaryColorLight,
      colorActiveDot: Theme.of(context).primaryColor,
    );
  }
}