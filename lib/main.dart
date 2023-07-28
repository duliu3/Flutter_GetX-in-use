import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_in_use/CustomAnimatedBottomBar.dart';
import 'package:flutter_getx_in_use/main_controller.dart';
import 'package:flutter_getx_in_use/page.dart';
import 'package:flutter_getx_in_use/state/state.dart';
import 'package:flutter_getx_in_use/user/user_page.dart';
import 'package:get/get.dart';
import 'features/features_page.dart';
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
      home: HomePage(),
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const HomePage()),
        GetPage(name: "/features", page: () => const FeaturesPage()),
        GetPage(name: "/user", page: () => const UserPage()),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _inactiveColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text(
              "GetX in use",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: SafeArea(child: getBody()),
          bottomNavigationBar: _buildBottomBar(),
        );
  }

  Widget getBody() {
    List<Widget> pages = [
      FeaturesPage(),
      UserPage(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }

  Widget _buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
          icon: Icon(Icons.apps),
          title: Text('Home'),
          activeColor: Colors.green,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: Icon(Icons.people),
          title: Text('Users'),
          activeColor: Colors.purpleAccent,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
