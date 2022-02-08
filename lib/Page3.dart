
import 'package:flutter/material.dart';
import 'package:dev_app/MatchResult.dart';
import 'dart:convert';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _Page3();
  }
}

class _Page3 extends State<Page3> {
  int _myPoint = 0;
  int _myMatchPoint = 0;
  int _youPoint = 0;
  int _youMatchPoint = 0;
  String _myName = "";
  String _yourName = "";
  List<String> _gameResult = [];
  void updateState(){
    setState(() {});
  }
  bool checkGameIsOver(){
    if(11 == this._myPoint && 10 > this._youPoint){
      this._myMatchPoint++;
    } else if(11 == this._youPoint && 10 > this._myPoint){
      this._youMatchPoint++;
    } else if(11 < this._myPoint || 11 < this._youPoint){
      if(2 == this._myPoint - this._youPoint){
        this._myMatchPoint++;
      } else if(2 == this._youPoint - this._myPoint){
        this._youMatchPoint++;
      } else {
        return false;
      }
    } else {
      return false;
    }
    return true;
  }
  void _registData() async{
    String _jsonGameResult = jsonEncode(this._gameResult);
    MatchResult _data = MatchResult(
      myMatchPoint: this._myMatchPoint
      ,youMatchPoint: this._youMatchPoint
      ,myName: this._myName
      ,yourName: this._yourName
      ,gameResult: _jsonGameResult
    );
    await MatchResult.insertData(_data);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("スコアボード"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 1行目
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(' '),
                TextButton(
                  child: Text('$_myPoint',style:TextStyle(fontSize: 64)),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100,180),
                    backgroundColor: Colors.black,
                    primary: Colors.white,
                  ),
                  onPressed: (){
                    this._myPoint++;
                    updateState();
                  },
                ),
                const Text(' '),
                TextButton(
                  child: Text('$_myMatchPoint',style:TextStyle(fontSize: 32)),
                  style: TextButton.styleFrom(
                    fixedSize: Size(50,90),
                    backgroundColor: Colors.black,
                    primary: Colors.white,
                  ),
                  onPressed: (){
                    this._myMatchPoint++;
                    updateState();
                  },
                ),
                const Text(' '),
                const Text('-'),
                const Text(' '),
                TextButton(
                  child: Text('$_youMatchPoint',style:TextStyle(fontSize: 32)),
                  style: TextButton.styleFrom(
                    fixedSize: Size(50,90),
                    backgroundColor: Colors.black,
                    primary: Colors.white,
                  ),
                  onPressed: (){
                    this._youMatchPoint++;
                    updateState();
                  },
                ),
                const Text(' '),
                TextButton(
                  child: Text('$_youPoint',style:TextStyle(fontSize: 64)),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100,180),
                    backgroundColor: Colors.black,
                    primary: Colors.white,
                  ),
                  onPressed: (){
                    this._youPoint++;
                    updateState();
                  },
                ),
                const Text(' '),
              ],
            ),
            // 2行目
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: const Text('▽'),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100,20),
                    primary: Colors.black,
                  ),
                  onPressed: (){
                    this._myPoint--;
                    updateState();
                  },
                ),
                TextButton(
                  child: const Text('▽'),
                  style: TextButton.styleFrom(
                    fixedSize: Size(60,20),
                    primary: Colors.black,
                  ),
                  onPressed: (){
                    this._myMatchPoint--;
                    updateState();
                  },
                ),
                Container(
                  width:10
                ),
                TextButton(
                  child: const Text('▽'),
                  style: TextButton.styleFrom(
                    fixedSize: Size(60,20),
                    primary: Colors.black,
                  ),
                  onPressed: (){
                    this._youMatchPoint--;
                    updateState();
                  },
                ),
                TextButton(
                  child: const Text('▽'),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100,20),
                    primary: Colors.black,
                  ),
                  onPressed: (){
                    this._youPoint--;
                    updateState();
                  },
                ),
              ],
            ),
            // 3行目
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration:InputDecoration(
                      hintText: "自分の名前を入力"
                    ),
                    onChanged: (text){
                      this._myName = text;
                    }
                  ),
                ),
                TextButton(
                  child: const Text('ゲーム終了'),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100,20),
                    primary: Colors.black,
                  ),
                  onPressed: () async{
                    bool _gameIsOver = checkGameIsOver();
                    if(_gameIsOver){
                      this._gameResult.add(
                        this._myPoint.toString()
                        + "-"
                        + this._youPoint.toString());
                      this._myPoint = 0;
                      this._youPoint = 0;
                    } else {
                      var result = await showDialog<int>(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('エラー',style:TextStyle(fontSize: 12)),
                            content: Text('ゲームが終了していません。点数を見直してください。'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('OK'),
                                onPressed: () => Navigator.of(context).pop(1),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    updateState();
                  },
                ),
                Flexible(
                  child: TextField(
                    decoration:InputDecoration(
                      hintText: "相手の名前を入力"
                    ),
                    onChanged: (text){
                      this._yourName = text;
                    },
                  ),
                ),
              ],
            ),
            // 4行目
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  child: const Text('マッチ終了'),
                  style: TextButton.styleFrom(
                    fixedSize: Size(100,20),
                    primary: Colors.black,
                  ),
                  onPressed: () async{
                    String _message = this._myName + ' ' + this._myMatchPoint.toString() 
                      + '-' + this._youMatchPoint.toString() 
                      + ' ' + this._yourName + '\n';
                    for(int i = 0; i < this._gameResult.length; i++){
                      _message += this._gameResult[i] + '\n';
                    }

                    var result = await showDialog<int>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('確認',style:TextStyle(fontSize: 12)),
                          content: Text(
                            '以下の結果を保存します。よろしいですか？\n'+_message
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () => Navigator.of(context).pop(0),
                            ),
                            TextButton(
                              child: Text('OK'),
                              onPressed: () => Navigator.of(context).pop(1),
                            ),
                          ],
                        );
                      },
                    );
                    if(1==result){
                      _registData();
                    }
                  },
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: this._gameResult.length,
                itemBuilder: (BuildContext context, int index){
                  return (Text(this._gameResult[index]));
                },
              ),
            ),
          ]
        ),
      ),
    );
  }
}