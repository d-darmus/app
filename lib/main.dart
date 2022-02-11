import 'package:flutter/material.dart';
import 'package:dev_app/Page3.dart' show Page3;
import 'package:dev_app/Page4.dart' show Page4;

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
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages
      ),
    );
  }
}
