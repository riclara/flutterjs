import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController webView;

  String result = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("InAppWebView")),
      body: Stack(
        children: [
          InAppWebView(
            initialFile: "assets/js/index.html",
            onWebViewCreated: (InAppWebViewController controller) {
              webView = controller;
            },
            onLoadStart: (controller, url) {},
            onLoadStop: (controller, url) async {},
            onConsoleMessage: (InAppWebViewController controller,
                ConsoleMessage consoleMessage) {
              print("console message: ${consoleMessage.message}");
            },
          ),
          Padding(
            padding: EdgeInsets.all(26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text(result)),
                SizedBox(height: 80),
                ElevatedButton(
                  onPressed: () {
                    final rnd = Random().nextInt(100);
                    var result = webView.evaluateJavascript(
                        source: 'World.plus(4, $rnd)');
                    result.then((value) {
                      print('Result: $value');
                      this.result = value.toString();

                      setState(() {});
                    });
                  },
                  child: Text('EXEC'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
