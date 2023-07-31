import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:logger/logger.dart';

/// @author Alex
/// @date 2023/7/31
/// @Description:
class ChannelPage extends StatefulWidget {

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  static const platform = MethodChannel('my_channel');
  int _batteryLevel = -1;
  var logger = Logger();

  // Flutter invoke Android
  Future<void> _getBatteryLevel() async {
    try {
      showSnackBar("send to android");
      final int result = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = result;
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = -1;
      });
    }
  }

  //Android invoke Flutter
  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleMethod);
  }

  Future<dynamic> _handleMethod(MethodCall call) async {
    logger.d("android to flutter ${call.method}");
    switch (call.method) {
      case 'my_method':
        return showSnackBar(call.arguments['message']);
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details: "Method ${call.method} not implemented",
        );
    }
  }

  void showSnackBar(String message) {
    logger.d("showSnackBar $message");
    Get.showSnackbar(GetSnackBar(message: "$message",duration: Duration(seconds: 1),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Native Channel'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Battery level: $_batteryLevel'),
            ElevatedButton(
              child: Text('Get battery level'),
              onPressed: _getBatteryLevel,
            ),
          ],
        ),
      ),
    );
  }
}