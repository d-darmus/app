import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dev_app/Page1.dart';
import 'package:dev_app/Page2.dart';
import 'package:dev_app/Page3.dart';
import 'package:dev_app/Page4.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Develop'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _salary = 0;
  int _payment = 0;
  int _result = 0;
  late PageController _pageController;
  int _selectedIndex = 0;
  var _pages = [
    Page3(),
    Page4(),
  ];
  
  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose(){
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages
      ),
    );
  }
}
