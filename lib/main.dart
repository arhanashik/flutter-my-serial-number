import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:unique_identifier/unique_identifier.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Identify',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Identify'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _identifier = '...';

  @override
  void initState() {
    super.initState();
    _getIMEI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Device Uniqe Identifier',
            ),
            Text(
              '$_identifier',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getIMEI,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }

  _getIMEI() async {
    String os = Platform.operatingSystem; //in your code
    print(os);

    String identifier = "";
    if (Platform.isAndroid) {
      identifier = await UniqueIdentifier.serial;
    } else if (Platform.isIOS) {
      final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
      var data = await deviceInfoPlugin.iosInfo;
      identifier = data.identifierForVendor;
    }

    debugPrint("imei: " + identifier);

    setState(() => _identifier = identifier);
  }
}
