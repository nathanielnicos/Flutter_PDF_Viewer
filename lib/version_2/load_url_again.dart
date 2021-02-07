import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:my_pdf_app/version_2/api_service.dart';

class LoadUrlAgain extends StatefulWidget {
  @override
  _LoadUrlAgainState createState() => _LoadUrlAgainState();
}

class _LoadUrlAgainState extends State<LoadUrlAgain> {
  String _localFile;

  @override
  void initState() {
    super.initState();
    ApiService.loadPdf().then((val) {
      setState(() {
        _localFile = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My PDF App"),
        backgroundColor: Colors.teal,
      ),
      body: (_localFile != null)
          ? PDFView(
              filePath: _localFile,
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
