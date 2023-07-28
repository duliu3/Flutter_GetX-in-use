import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_in_use/page.dart';
import 'package:flutter_getx_in_use/state.dart';
import 'package:get/get.dart';
import 'websocket_control.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      home: MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/pageone': (context) => PageOne(),
        '/state_page': (context) => StatePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "GetX in use",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            // RichText(
            //     text: TextSpan(
            //         text: 'Go and Back',
            //         style: TextStyle(color: Colors.blue, fontSize: 30),
            //         recognizer: TapGestureRecognizer()
            //           ..onTap = () {
            //             print("Websocket onTap ");
            //             // Get.to(() => PageOne());
            //             Navigator.of(context).push(
            //               MaterialPageRoute(
            //                 builder: (context) => PageOne(),
            //                 settings: RouteSettings(name: '/middle'),
            //               ),
            //             );
            //           })),
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
                // Get.to(() => StatePage());
                Get.toNamed("/state_page");
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

class RestartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // Future.delayed(Duration.zero, () {
          //   runApp(MyApp());
          // });
        },
        child: Text('Exit'),
      ),
    );
  }
}
