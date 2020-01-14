import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:housesolutions/util/session.dart';
import 'package:housesolutions/widget/loading.dart';
import 'package:path_provider/path_provider.dart';

class InvoicePDF extends StatefulWidget {
  String idTrans;
  String url;
  InvoicePDF(this.idTrans, this.url);

  @override
  _InvoicePDFState createState() => _InvoicePDFState();
}

class _InvoicePDFState extends State<InvoicePDF> {
  final _key = GlobalKey<ScaffoldState>();
  String pathPDF, error;

  @override
  void initState() { 
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
        print(pathPDF);
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    try {
      if (widget.url != null) {
        var user = await sessions.load("token");
        final filename = widget.url.substring(widget.url.lastIndexOf("/") + 1);
        print("${widget.url}/$user");
        var request = await HttpClient().getUrl(Uri.parse("${widget.url}/$user"));
        var response = await request.close();
        var bytes = await consolidateHttpClientResponseBytes(response);
        String dir = (await getApplicationDocumentsDirectory()).path;
        File file = new File('$dir/$filename');
        await file.writeAsBytes(bytes);
        return file;
      }else{
        setState(() {
          error = "Invoice not found";
        });
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (pathPDF == null) 
      return Scaffold(
        appBar: AppBar(
          brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
          title: Text("Invoice"),
        ),
        body: Center(
          child: error != null ? Text(error):LoadingBlock(),
        ),
      );
    return PDFViewerScaffold(
      appBar: AppBar(
        brightness: Platform.isIOS ? Brightness.light:Brightness.dark,
        title: Text(widget.idTrans.toUpperCase()),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      path: pathPDF
    );
  }
}
