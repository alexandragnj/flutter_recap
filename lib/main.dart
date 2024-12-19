import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ex 1
class Area {
  final double length;
  final double width;
  final double area;

  //const Area(this.length, this.width) : area =length * width;
  const Area._internal(this.length, this.width) : area = length * width;

  factory Area(double l, double w) {
    if (l < 0 || w < 0) {
      throw Exception("Length and breath must be positive.");
    } else {
      return Area._internal(l, w);
    }
  }

  void display() {
    print("Area is $area");
  }
}

// ex 2
class Person {
  String firstName;
  String lastName;

  Person(this.firstName, this.lastName);

  //factory
  factory Person.fromMap(Map<String, Object> map) {
    final firstName = map['firstName'] as String;
    final lastName = map['lastName'] as String;
    return Person(firstName, lastName);
  }
}

// ex 3
enum ShapeType { circle, rectangle }

abstract class Shape {

  factory Shape(ShapeType st){
    if(st== ShapeType.circle){
      return Circle();
    } else if(st== ShapeType.rectangle){
      return Rectangle();
    } else {
      throw Exception('No shape');
    }
  }
  void draw();
}

class Circle implements Shape {
  @override
  void draw() {
    print('Drawing Circle');
  }
}

class Rectangle implements Shape {
  @override
  void draw() {
    print('Drawing rectangle');
  }
}

// ex 4
class Person2{
  final String name;

  Person2._internal(this.name);

  static final Map<String, Person2> _cache=<String, Person2>{};

  factory Person2(String name){
    if(_cache.containsKey('name')){
      return _cache[name]!;
    } else {
      final person2=Person2._internal(name);
      _cache[name]=person2;
      return person2;
    }
  }
}

void test() {
  // Area a = Area(-150, 250); //area can't be negative, we have to create a construct to vaidate de input (factory)
  Area a1 = Area(150, 250);
  a1.display();

  Person p = Person('Baimal', 'Jackson');
  print('Person fullname is ${p.firstName} ${p.lastName}');

  var myMap = {'firstName': 'Jhon', 'lastName': 'Mark'};
  Person p2 = Person.fromMap(myMap);
  print('Person fullname is ${p2.firstName} ${p2.lastName}');

  List<Shape> shapes=[];
  shapes.add(Shape(ShapeType.circle));
  shapes.add(Shape(ShapeType.rectangle));
  for(Shape i in shapes){
    i.draw();
  }

  final person1=Person2('John');
  final person2=Person2('John');
  final person3=Person2('John');

  print(person2.hashCode);
  print(person1.hashCode);
  print(person3.hashCode);
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
