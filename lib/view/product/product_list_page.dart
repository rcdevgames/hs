import 'package:flutter/material.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final _key = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() { 
    super.initState();
    
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: Product page
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(""),
      ),

    );
  }
}