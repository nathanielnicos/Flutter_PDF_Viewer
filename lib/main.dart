import 'package:flutter/material.dart';
import 'file:///D:/my_flutter/my_pdf_app/lib/version_1/load_asset.dart';
import 'file:///D:/my_flutter/my_pdf_app/lib/version_1/load_url.dart';
import 'file:///D:/my_flutter/my_pdf_app/lib/version_2/load_asset_again.dart';
import 'file:///D:/my_flutter/my_pdf_app/lib/version_2/load_url_again.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My PDF App',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My PDF App"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Using package: flutter_plugin_pdf_viewer: ^1.0.7", style: TextStyle(color: Colors.teal),),
            SizedBox(height: 4),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoadAsset();
                }));
              },
              child: Text("Load PDF from asset"),
            ),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoadUrl();
                }));
              },
              child: Text("Load PDF from URL"),
            ),
            SizedBox(height: 24),
            Text("Using package: flutter_pdfview: ^1.0.0+10", style: TextStyle(color: Colors.teal),),
            SizedBox(height: 4),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoadAssetAgain();
                }));
              },
              child: Text("Load PDF from asset"),
            ),
            FlatButton(
              color: Colors.teal,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoadUrlAgain();
                }));
              },
              child: Text("Load PDF from URL"),
            ),
          ],
        ),
      ),
    );
  }
}
