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
class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed("/");
              },
              child: Text('ALEX'),
            ),
          ],
        ),
      ),
    );
  }

}