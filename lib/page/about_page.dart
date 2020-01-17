//Created by 1vPy on 2019/10/31.
import 'package:bkapp_flutter/page/base_state.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AboutPageState();
}

class AboutPageState extends BaseState<AboutPage> {
  double lastX = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Listener(
        onPointerDown: (PointerDownEvent event) {
          print('onPointerDown = $event');
          lastX = event.position.dx;
        },
        onPointerUp: (PointerUpEvent event) {
          print('onPointerUp = $event');
          if (event.position.dx - lastX > 80) {
            Navigator.of(context).pop();
          } else if (event.position.dx - lastX < -80) {
            to2Page();
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: FlutterLogo(
                    size: 120,
                  ),
                ),
                Hero(
                  tag: 'appName',
                  child: Text('bkApp_flutter'),
                )
              ],
              mainAxisSize: MainAxisSize.min,
            )),
      ),
    );
  }

  void to2Page() {
    double lastX = 0.0;

    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
              .animate(
                  CurvedAnimation(parent: animation, curve: Curves.decelerate)),
          child: Scaffold(
            body: Listener(
              onPointerDown: (PointerDownEvent event) {
                print('onPointerDown = $event');
                lastX = event.position.dx;
              },
              onPointerUp: (PointerUpEvent event) {
                print('onPointerUp = $event');
                if (event.position.dx - lastX > 80) {
                  Navigator.of(context).pop();
                } else if (event.position.dx - lastX < -80) {
                  to3Page();
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Container(
                  alignment: Alignment.topRight,
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Hero(
                        tag: 'appName',
                        child: Text('bkApp_flutter'),
                      ),
                      Hero(
                        tag: 'logo',
                        child: FlutterLogo(
                          size: 40,
                        ),
                      ),
                    ],
                  )),
            ),
          ));
    }));
  }

  void to3Page() {
    double lastX = 0.0;
    Navigator.push(context, PageRouteBuilder(pageBuilder: (BuildContext context,
        Animation animation, Animation secondaryAnimation) {
      return SlideTransition(
          position: Tween<Offset>(
                  begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
              .animate(
                  CurvedAnimation(parent: animation, curve: Curves.decelerate)),
          child: Scaffold(
            body: Listener(
              onPointerDown: (PointerDownEvent event) {
                print('onPointerDown = $event');
                lastX = event.position.dx;
              },
              onPointerUp: (PointerUpEvent event) {
                print('onPointerUp = $event');
                if (event.position.dx - lastX > 80) {
                  Navigator.of(context).pop();
                } else if (event.position.dx - lastX < -80) {
                  Navigator.of(context)
                      .popUntil(ModalRoute.withName('/homePage'));
                }
              },
              behavior: HitTestBehavior.opaque,
              child: Center(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: FlutterLogo(
                          size: 40,
                        ),
                      ),
                      Hero(
                        tag: 'appName',
                        child: Text('bkApp_flutter'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ));
    }));
  }
}
