import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class Badges extends StatelessWidget {
  Color color;
  Color textColor;
  Preference<int> future;
  Widget child;
  Badges({this.color = const Color(0xFFF98866), this.textColor = const Color(0xFFFFFFFF), this.future, this.child});

  @override
  Widget build(BuildContext context) {
    return PreferenceBuilder<int>(
      preference: future,
      builder: (ctx, data) {
        return Badge(
          padding: const EdgeInsets.all(8),
          badgeColor: color,
          badgeContent: Text(data.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: textColor)),
          showBadge: data != 0,
          child: child
        );
      },
    );
  }
}