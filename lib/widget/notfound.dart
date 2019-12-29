import 'package:flutter/material.dart';

class NotFound extends StatelessWidget {
  Future<void> Function() onRefresh;
  String image_asset;

  NotFound({Key key, this.onRefresh, this.image_asset}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        RefreshIndicator(
          key: key,
          onRefresh: onRefresh,
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
            return SizedBox(height: 30);
           },
          ),
        ),
        Center(
          child: Image.asset(image_asset),
        )
      ],
    );
  }
}