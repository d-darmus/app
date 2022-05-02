import 'package:flutter/material.dart';
import 'package:dev_app/record/MatchResultPage.dart' show MatchResultPage;
import 'package:dev_app/main/TokutenbanPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '得点版アプリ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  /// タブ定義
  final List<Tab> tabs = <Tab>[
    const Tab(text:'得点板'),
    const Tab(text:'試合結果'),
  ];
  late TabController _tabController;
  
  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.blue,
        title:TabBar(
          tabs:tabs,
          controller:_tabController,
          unselectedLabelColor:Colors.grey,
          indicatorColor:Colors.lightBlue,
          indicatorSize:TabBarIndicatorSize.tab,
          indicatorWeight: 2,
          indicatorPadding: const EdgeInsets.symmetric(horizontal:18.0,vertical:8),
          labelColor: Colors.white,
        ),
      ),
      body: TabBarView(
        controller:_tabController,
        children: tabs.map((tab){
          return _createTab(tab);
        }).toList(),
      ),
    );
  }

  /// タブの切り替えメソッド
  Widget _createTab(Tab tab){
    switch(tab.text){
      case "得点版" : return const TokutenbanPage();
      case "試合結果" : return const MatchResultPage();
      default : return const TokutenbanPage();
    }
  }
}
