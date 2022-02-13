
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dev_app/MatchResult.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class Page5 extends StatefulWidget {
  const Page5({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _Page5();
  }
}

class _Page5 extends State<Page5> {
  String _input = "";
  /** 表示更新 */
  void updateState(){
    setState(() {});
  }
  void loadTextFile(){
    List<dynamic> list = jsonDecode(this._input);
    MatchResult match = MatchResult(
      myMatchPoint: list[0]['myMatchPoint'],
      youMatchPoint: list[0]['youMatchPoint'],
      myName: list[0]['myName'].toString(),
      yourName: list[0]['yourName'].toString(),
      gameResult: list[0]['gameResult'].toString()
    );
    MatchResult.insertData(match);
  }
  void exportFile() async{
    List<MatchResult> _result = await MatchResult.getDatas();
    List<Map<String,dynamic>> list = [];
    for( MatchResult res in _result ){
      list.add(res.toMap());
    }
    String json = jsonEncode(list);
    this._input = json;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("設定"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (text){
                this._input = text;
              }
            ),
            SelectableText('$_input'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TextButton(child: Text('読込'),onPressed: (){
                  loadTextFile();
                  updateState();
                }),
                TextButton(child: Text('出力'),onPressed: (){
                  exportFile();
                  updateState();
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}