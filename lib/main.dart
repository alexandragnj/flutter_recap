import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//ex 1 generics integer or double
T eitherIntOrDouble<T extends num>() {
  switch (T) {
    case int:
      return 1 as T;
    case double:
      return 1.0 as T;
    default:
      throw Exception('Not supported');
  }
}

//ex 2 type matching
/*bool doTypesMatch(Object a, Object b) {
  return a.runtimeType == b.runtimeType;
}*/
bool doTypesMatch<L, R>(L a, R b) => L == R;

//ex 3 constrained generic type definition

typedef BreathingThings<T extends CanBreathe> = Map<String, T>;

void describe(Iterable<BreathingThings> values) {
  for (final map in values) {
    for (final keyAndValues in map.entries) {
      print('Will call breathe() on ${keyAndValues.key}');
      keyAndValues.value.breathe();
    }
  }
}

mixin CanBreathe {
  void breathe();
}

class Person with CanBreathe {
  const Person();

  @override
  void breathe() {
    print('Person is breathing..');
  }
}

class Fish with CanBreathe {
  const Fish();

  @override
  void breathe() {
    print('Fish is breathing..');
  }
}

// ex4 unconstrained generic type definition
typedef KeyValue<K, V> = MapEntry<K, V>;

// ex5 specializing generic type definition
typedef JSON<T> = Map<String, T>;

void test() async {
//ex1
  final double doubleValue = eitherIntOrDouble();
  print(doubleValue);
  final int intValue = eitherIntOrDouble();
  print(intValue);

//ex2
  print(doTypesMatch(1, 2));
  print(doTypesMatch(1, 2.2));
  print(doTypesMatch(1, 'Foo'));
  print(doTypesMatch('Foo', 'Bar'));

//ex3
  const momAndDad = {
    'mom': Person(),
    'dad': Person(),
  };

  const brotherAndSisterAndFish = {
    'Brother': Person(),
    'Sister': Person(),
    'Fishy': Fish(),
  };

  final allValues = [momAndDad, brotherAndSisterAndFish];
  describe(allValues);

//ex4
  const one = KeyValue(1, 2);
  print(one);
  const two = KeyValue(1, 2.2); //MapEntry<int, double>
  print(two);
  const three = KeyValue(1, 'Foo'); //MapEntry<int, String
  print(three);
  const KeyValue four = KeyValue(1, 2); //MapEntry<dynamic, dynamic>
  print(four);

//ex5
  const JSON<String> json = {
    'name': 'John',
    //'age': 30,
    'address': '123 Main st',
  };
  print(json);

//ex6

//ex7

//ex8
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    test();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
// This is the theme of your application.
//
// TRY THIS: Try running your application with "flutter run". You'll see
// the application has a purple toolbar. Then, without quitting the app,
// try changing the seedColor in the colorScheme below to Colors.green
// and then invoke "hot reload" (save your changes or press the "hot
// reload" button in a Flutter-supported IDE, or press "r" if you used
// the command line to start the app).
//
// Notice that the counter didn't reset back to zero; the application
// state is not lost during the reload. To reset the state, use hot
// restart instead.
//
// This works for code too, not just values: Most code changes can be
// tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

  @override
  Widget build(BuildContext context) {
// This method is rerun every time setState is called, for instance as done
// by the _incrementCounter method above.
//
// The Flutter framework has been optimized to make rerunning build methods
// fast, so that you can just rebuild anything that needs updating rather
// than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
// TRY THIS: Try changing the color here to a specific color (to
// Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
        child: Column(
// Column is also a layout widget. It takes a list of children and
// arranges them vertically. By default, it sizes itself to fit its
// children horizontally, and tries to be as tall as its parent.
//
// Column has various properties to control how it sizes itself and
// how it positions its children. Here we use mainAxisAlignment to
// center the children vertically; the main axis here is the vertical
// axis because Columns are vertical (the cross axis would be
// horizontal).
//
// TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
// action in the IDE, or press "p" in the console), to see the
// wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
