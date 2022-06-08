import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  bool _showAppBar = true;

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    const paddingAppBar = 8.0;
    return Scaffold(
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          final ScrollDirection direction = notification.direction;
          setState(() {
            if (direction == ScrollDirection.reverse) {
              _showAppBar = false;
            } else if (direction == ScrollDirection.forward) {
              _showAppBar = true;
            }
          });
          return true;
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Stack(
              children: [
                ListView.builder(
                  itemCount: 100,
                  itemBuilder: (_, i) => ListTile(
                      title: Text('$i'),
                      contentPadding: i == 0
                          ? const EdgeInsetsDirectional.only(
                              top: 56.0, start: 16.0)
                          : null),
                ),
                PositionedDirectional(
                  top: 0.0,
                  child: AnimatedSlide(
                    duration: duration,
                    offset: _showAppBar ? Offset.zero : const Offset(0.0, 0.0),
                    child: AnimatedOpacity(
                      duration: duration,
                      opacity: _showAppBar ? 1 : 0,
                      child: Container(
                        margin: const EdgeInsets.all(paddingAppBar),
                        padding: const EdgeInsets.all(paddingAppBar),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.blue,
                        ),
                        height: 56,
                        width: MediaQuery.of(context).size.width -
                            (paddingAppBar * 2),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.menu,
                              size: 32,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
