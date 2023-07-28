import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../page.dart';
import '../state/state.dart';
import '../websocket_control.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Way 1
                // Get.to(() => PageOne());
                // Way 2
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PageOne(),
                    settings: RouteSettings(name: '/middle'),
                  ),
                );
              },
              child: Text('Navigation'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => StatePage());
                // Get.toNamed("/state_page");
              },
              child: Text('State Management'),
            ),

            ElevatedButton(
              onPressed: () {
                Get.to(() => WebSocketPage(url: 'wss://'));
              },
              child: Text('Go Websocket'),
            ),
          ],
        ),
      ),
    );
  }

}