import 'package:flutter/material.dart';
import 'package:dev_app/editPage/edit_page.dart';
import 'package:dev_app/Page4.dart' show Page4;
import 'package:dev_app/TokutenbanPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  final List<Tab> tabs = <Tab>[
    const Tab(text:'得点板'),
    const Tab(text:'試合結果'),
    // const Tab(text:'編集'),
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

  Widget _createTab(Tab tab){
    if(tabs[0] == tab){ return const TokutenbanPage(); }
    if(tabs[1] == tab){ return const Page4(); }
    // if(tabs[2] == tab){ return const EditPage(); }
    return const TokutenbanPage();
  }
}
