import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const EventChannel _eventChannel =
      EventChannel('proximity_sensor');

  double _proximity = 0.0;

  @override
  void initState() {
    super.initState();
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

 void _onEvent(Object? event) {
  if(event != null){
    setState(() {
      _proximity = double.parse(event.toString());
    });
  }
  }

  void _onError(Object error) {
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Proximity Sensor Example'),
        ),
        body: Center(
          child: Text('Proximity: $_proximity'),
        ),
      ),
    );
  }
}
