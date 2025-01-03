import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

int? add([int? a, int? b]) {
  return a + b;
}
//ex 3 Addition of two optional integers

extension NullableAdd<T extends num> on T? {
  T? operator +(T? other) {
    final thisShadow = this;
    //if this != null $$ other ==null, return this
    if (this != null && other == null) {
      return this as T;
    }
    //if this == null $$ other !=null, return other
    else if (this == null && other != null) {
      return other;
    }
    //if this != null $$ other !=null, return this + other
    else if (thisShadow != null && other != null) {
      return thisShadow + other as T;
    }
    //if this != null $$ other !=null, return 0
    else {
      return 0 as T;
    }
  }
}

// ex 4 Subtracting string from another string
extension Remove on String {
  String operator -(String other) => replaceAll(other, '');
}

// ex 5 Subtracting iterable from another iterable
extension RemoveMinus<T> on Iterable<T> {
  Iterable<T> operator -(Iterable<T> other) =>
      this.where((element) => !other.contains(element));
}

//ex 6 Maps
extension MapOperations<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> other) => {
        ...this,
        ...other,
      };

  Map<K, V> operator -(Map<K, V> other) {
    return {...this}..removeWhere((key, value) {
        return other.containsKey(key) && other[key] == value;
      });
  }

  Iterable<Map<K, V>> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield this;
    }
  }
}

// ex 7 Cross data type operators
class Person {
  final String name;

  const Person({required this.name});

  @override
  String toString() => 'Person (name=$name)';
}

class Pet {
  final String name;

  const Pet({required this.name});

  @override
  String toString() => 'Pet (name=$name)';
}

class Family {
  final List<Person> members;
  final List<Pet> pets;

  const Family({
    required this.members,
    required this.pets,
  });

  @override
  String toString() => 'Family (members =$members, pets=$pets)';
}

extension on Person {
  Family operator +(Person other) => Family(members: [this, other], pets: []);

  Family operator &(Pet other) => Family(members: [this], pets: [other]);
}

extension on Family {
  Family operator &(Pet other) =>
      Family(members: members, pets: [...pets, other]);

  Family operator +(Person other) =>
      Family(members: [...members, other], pets: pets);

  Family operator ^(Family other) => Family(
      members: [...members, ...other.members], pets: [...pets, ...other.pets]);
}

// ex 8 Operators on class definitions
class Person2 {
  final int age;

  Person2({required this.age});

  Person2 operator +(int age) => Person2(age: this.age + age);

  @override
  String toString() => 'Person (age =$age)';
}

void test() {
  //ex3
  print(add(3, 2));

  //ex4
  print('Foo bar' - 'Foo'); // bar

  //ex5
  print([1, 2, 3] - [1, 2]);

  //ex6
  print({'name': 'John', 'age': 42} + {'address': '123 Main St'});
  print({'name': 'John', 'age': 42} - {'age': 42});
  print({'name': 'John'} * 2);

  //ex7
  final mom = Person(name: 'Jane');
  final dad = Person(name: 'John');
  final son = Person(name: 'Jack');
  final daughter = Person(name: 'Jill');

  final whiskers = Pet(name: 'Whiskers');

  final family = mom + dad;
  print(family);

  final withWhiskers = family & whiskers;
  print(withWhiskers);

  final withSon = withWhiskers + son;
  print(withSon);

  //ex8
  final meThisYear=Person2(age: 30);
  print(meThisYear +1);
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
