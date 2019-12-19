import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:responsive_screen/responsive_screen.dart';

class UserPage extends StatelessWidget {
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return RefreshIndicator(
          key: _refreshKey,
          onRefresh: () => null,
          child: ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: hp(35),
                color: Theme.of(context).primaryColor,
                child: CachedNetworkImage(
                  
                ),
              )
            ],  
          ),
        );
      }
    );
  }
}