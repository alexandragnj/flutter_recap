import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

extension on int {
  int get timesFour => this * 4;
}

//ex 1 extending string
extension on String {
  String get reversed => this.split('').reversed.join();
}

//ex 2 sum of iterable
extension SumOfIterable<T extends num> on Iterable<T> {
  T get sum => reduce((a, b) => a + b as T);
}

//ex 3 range on int
extension on int {
  Iterable<int> to(int end, {bool inclusive = true}) => end > this
      ? [for (var i = this; i < end; i++) i, if (inclusive) end]
      : [for (var i = this; i > end; i--) i, if (inclusive) end];
}

//ex 4 finding duplicate values
extension on Iterable {
  bool get containsDuplicateValues => toSet().length != length;
}

//ex 5 finding and mapping keys and values on maps
extension Find<K, V, R> on Map<K, V> {
  R? find<T>(
    K key,
    R? Function(T value) cast,
  ) {
    final value = this[key];
    if (value != null && value is T) {
      return cast(value as T);
    } else {
      return null;
    }
  }
}

//ex 6 extending enums
enum AnimalType { cat, dog, goldFish }

extension on Enum {
  bool get nameContainsUpperCaseLetters => name.contains(RegExp(r'[A-Z]'));
}

//ex 7 extending functions
int add(int a, int b) => a + b;

int substract(int a, int b) => a - b;

typedef IntFunction = int Function(int, int);

extension on IntFunction {
  int callWithRandomValues() {
    final rnd1 = Random().nextInt(100);
    final rnd2 = Random().nextInt(100);
    print('Random values =$rnd1, $rnd2');
    return call(rnd1, rnd2);
  }
}

//ex 8 why do we need names for extension like ex 2
class Person {
  final String name;
  final int age;

  const Person({required this.name, required this.age});
}

extension ShortDescription on Person {
  String get description => '$name ($age)';
}

extension LongDescription on Person {
  String get description => '$name in ($age) years old';
}

void test() async {
  //ex1
  print('Hello'.reversed);

  //ex2
  print([1, 2, 2].sum);
  print([1.1, 2.2, 3.3].sum);

  //ex3
  //1.to(10) -> Iterable[1,2,3,4,5,6,7,8,9,10]
  //1.to(10, inclusive: false)
  print(1.to(10));
  print(10.to(1));
  print(1.to(10, inclusive: false));

  //ex4
  print([1, 2, 3, 1].containsDuplicateValues); //true
  print(['a', 'b', 'A'].containsDuplicateValues); //false
  print(['a', 'b', 'a'].containsDuplicateValues); //true

  //ex5
  final json = {
    'Name': 'Foo',
    'Age': 42,
  };

  final String? ageAsString = json.find<int>(
    'age',
    (int age) => age.toString(),
  );
  print(ageAsString);

  //ex6
  print(AnimalType.cat.nameContainsUpperCaseLetters); //false
  print(AnimalType.goldFish.nameContainsUpperCaseLetters); //true

  //ex7
  print(add.callWithRandomValues());

  //ex8
  const jack=Person(name: 'Jack', age: 20);
  print(ShortDescription(jack).description);
  print(LongDescription(jack).description);
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
