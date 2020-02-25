import 'package:flutter/material.dart';
import 'package:housesolutions/r.dart';

class ErrorPage extends StatelessWidget {
  String message;
  String buttonText;
  Function onPressed;
  ErrorPage({Key key, @required this.message, @required this.onPressed, @required this.buttonText}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) {
          if (message.contains("SocketException")) {
            return Image.asset(R.assetsImagesOffline, scale: 2.5);
          }
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(R.assetsImagesTerjadiKesalahan, scale: 2.5),
              SizedBox(height: 10),
              Text(message??"", textAlign: TextAlign.center),
              SizedBox(height: 15),
              RaisedButton(
                child: Text(buttonText, style: TextStyle(color: Colors.white)),
                color: Theme.of(context).primaryColor,
                onPressed: onPressed,
              )
            ],
          );
        }
      ),
    );
  }
}