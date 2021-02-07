import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

class LoadAssetAgain extends StatefulWidget {
  @override
  _LoadAssetAgainState createState() => _LoadAssetAgainState();
}

class _LoadAssetAgainState extends State<LoadAssetAgain> {
  String _localFile = "";

  @override
  void initState() {
    super.initState();
    fromAsset("assets/practical_flutter.pdf", "practical_flutter.pdf")
        .then((value) {
      setState(() {
        _localFile = value.path;
      });
    });
  }

  Future<File> fromAsset(String asset, String fileName) async {
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception("Error parsing asset file!");
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My PDF App"),
        backgroundColor: Colors.teal,
      ),
      body: Center(
        child: RaisedButton(
          color: Colors.teal,
          child: Text("Click Me!"),
          onPressed: () {
            if (_localFile != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenPdf(path: _localFile),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class OpenPdf extends StatefulWidget {
  final String path;

  OpenPdf({Key key, this.path}) : super(key: key);

  @override
  _OpenPdfState createState() => _OpenPdfState();
}

class _OpenPdfState extends State<OpenPdf> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int pages = 0;
  int currentPage = 0;
  bool isReady = false;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF"),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: true,
            autoSpacing: false,
            pageFling: true,
            pageSnap: true,
            defaultPage: currentPage,
            fitPolicy: FitPolicy.BOTH,
            preventLinkNavigation: false,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
            onPageChanged: (int page, int total) {
              setState(() {
                currentPage = page;
              });
            },
          ),
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(8),
            color: Colors.teal,
            child: Text("${currentPage + 1} / $pages"),
          ),
          errorMessage.isEmpty
              ? !isReady
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FutureBuilder<PDFViewController>(
            future: _controller.future,
            builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton.extended(
                  onPressed: () async {
                    await snapshot.data
                        .setPage(0);
                  },
                  label: Text("First"),
                );
              }
              return Container();
            },
          ),
          SizedBox(width: 8),
          (currentPage - 1 > 0) ? FutureBuilder<PDFViewController>(
            future: _controller.future,
            builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton.extended(
                  onPressed: () async {
                    await snapshot.data
                        .setPage(currentPage - 1);
                  },
                  label: Text("${currentPage - 1}"),
                );
              }
              return Container();
            },
          ) : Container(),
          SizedBox(width: 8),
          (currentPage + 3 <= pages) ? FutureBuilder<PDFViewController>(
            future: _controller.future,
            builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton.extended(
                  onPressed: () async {
                    await snapshot.data
                        .setPage(currentPage + 3);
                  },
                  label: Text("${currentPage + 3}"),
                );
              }
              return Container();
            },
          ) : Container(),
          SizedBox(width: 8),
          FutureBuilder<PDFViewController>(
            future: _controller.future,
            builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
              if (snapshot.hasData) {
                return FloatingActionButton.extended(
                  onPressed: () async {
                    await snapshot.data
                        .setPage(pages);
                  },
                  label: Text("Last"),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
