import 'package:flutter/material.dart';
import 'package:housesolutions/r.dart';
import 'package:housesolutions/util/all_translation.dart';
import 'package:housesolutions/util/nav_service.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:responsive_screen/responsive_screen.dart';

class WelcomePage extends StatelessWidget {
  List<Slide> slides = new List();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    slides.add(
      new Slide(
        centerWidget: SizedBox(
          height: hp(90),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(R.assetsImagesBanner1),
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
          height: hp(90),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(R.assetsImagesBanner2),
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
          height: hp(90),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(R.assetsImagesBanner3),
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