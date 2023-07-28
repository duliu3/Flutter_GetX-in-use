import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_in_use/main.dart';
import 'package:get/get.dart';

/// @author Alex
/// @date 2023/7/28
/// @Description:
class PageOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            children: [
              Text("Page 1", style: TextStyle(color: Colors.black),),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  // if u use off here to back home, if will create another home page
                  // Get.off(()=>MyHomePage());
                },
                child: Text('Go Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => PageTwo());
                },
                child: Text('Go to Page Two'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            children: [
              Text("Page 2", style: TextStyle(color: Colors.black),),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Go Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  //if you use off() here, it would not pop current page
                  Get.off(() => PageThree());
                },
                child: Text('Go to Page Three'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class PageThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 400,
          child: Column(
            children: [
              Text("Page 3", style: TextStyle(color: Colors.black),),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text('Go Back'),
              ),
              ElevatedButton(
                onPressed: () {
                  //if u use offAll() or pushNamedAndRemoveUntil()
                  // it will pop all other pages including main page
                  // Get.offAll(() => PageOne());
                  // Navigator.of(context).pushNamedAndRemoveUntil('/pageone', (Route<dynamic> route) => false);

                  // next two are available
                  // Navigator.of(context).popUntil((route) {
                  //   if (route.settings.name == '/middle') {
                  //     return true;
                  //   } else {
                  //     // Navigator.of(context).removeRoute(route);
                  //     return false;
                  //   }
                  // });
                  Get.until((route) {
                    if (route.settings.name == '/middle') {
                      return true;
                    } else {
                      return false;
                    }
                  });
                },
                child: Text('Go to Page One'),
              ),
              ElevatedButton(
                onPressed: () {
                  //if u use offAll() it will pop all other pages including main page
                  // Get.offAll(() => PageOne());
                  Get.offAll(() => MyHomePage());
                },
                child: Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

