import 'package:audioplayer/models/drag_token_position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:audioplayer/services/pool_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final services = await PoolServices.initialize();
  _setupLocator(services);
  runApp(ServicesProvider(
    services: services,
    child: MyApp(),
  ));
}

void _setupLocator(PoolServices poolServices) {
  GetIt.instance.registerSingleton(poolServices);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      title: 'Futgolazo',
      home: MyHomePage(),
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => DragTokenPosition(),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<DragTokenPosition>(
            builder: (context, value, child) {
              return Text('tessssss ${value.X} - ${value.Y}');
            },
          ),
        ),
        body: Center(
          child: Container(
            height: 300,
            width: 350,
            color: Colors.red[50],
            child: Stack(
              alignment: Alignment.center,
              fit: StackFit.loose,
              children: [
                leftDragTarget(),
                rightDragTarget(),
                bottomDragTarget(),
                draggableButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget draggableButton() {
    return Positioned(
      top: 80,
      left: 130,
      child: Consumer<DragTokenPosition>(
        builder: (context, value, child) {
          return Listener(
            onPointerMove: (pointer) {
              print('object ${pointer.position}');
              value.changePosition(pointer.position);
              setState(() {});
            },
            child: Draggable<int>(
              data: 1,
              feedback: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.add_to_home_screen),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(500),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              childWhenDragging: Container(
                color: Colors.blue[100],
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.add_to_home_screen),
                ),
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Icon(Icons.add_to_home_screen),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(500),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget bottomDragTarget() {
    return Positioned(
      bottom: 0,
      left: 80,
      child: DragTarget<int>(
        builder: (BuildContext ctx, List<int> incoming, List rejected) {
          return Container(
            width: 160,
            height: 90,
            color: Colors.green[300],
          );
        },
        onWillAccept: (data) {
          print("onWillAccept BOTTOM");
          return true;
        },
        onAccept: (data) {
          print("ACEPTADO BOTTOM");
        },
        onLeave: (data) {
          print("LEAVE");
        },
      ),
    );
  }

  Widget rightDragTarget() {
    return Positioned(
      top: 0,
      right: 0,
      child: DragTarget<int>(
        builder: (BuildContext ctx, List<int> incoming, List rejected) {
          return Container(
            width: 100,
            height: 300,
            color: Colors.yellow[300],
          );
        },
        onWillAccept: (data) {
          print("onWillAccept RUGHT");
          return true;
        },
        onAccept: (data) {
          print("ACEPTADO RIGHT");
        },
        onLeave: (data) {
          print("LEAVE");
        },
      ),
    );
  }

  Widget leftDragTarget() {
    return Positioned(
      top: 0,
      left: 0,
      child: DragTarget<int>(
        builder: (BuildContext ctx, List<int> incoming, List rejected) {
          return Container(
            width: 100,
            height: 300,
            color: Colors.deepPurple[200],
          );
        },
        onWillAccept: (data) {
          print("onWillAccept LEFT");
          return true;
        },
        onAccept: (data) {
          print("ACEPTADO LEFT");
        },
        onLeave: (data) {
          print("LEAVE");
        },
      ),
    );
  }
}
