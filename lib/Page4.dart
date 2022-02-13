
import 'dart:convert';

import 'package:dev_app/MatchResult.dart';
import 'package:flutter/material.dart';

class Page4 extends StatefulWidget {
  const Page4({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _Page4();
  }
}

class _Page4 extends State<Page4> {
  List<MatchResult> _resultList = [];
  List<dynamic> _gameResult = [];
  void _initialize() async{
    this._resultList = await MatchResult.getDatas();
    this._convertGameResultJson(); 
    try{
      setState(() {});
    } catch(e){
      print(e);
    }
  }
  void _convertGameResultJson(){
    this._gameResult.clear();
    for( MatchResult match in this._resultList){
      this._gameResult.add(jsonDecode(match.gameResult));
    }
  }
  String _getMyPoint(String str){
    List<String> _result = str.split('-');
    return _result[0];
  }
  String _getYourPoint(String str){
    List<String> _result = str.split('-');
    return _result[1];
  }

  @override
  Widget build(BuildContext context) {
    this._initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text("試合結果"),
      ),
      body: Center(
        // 1列目
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // 1行目
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('表示'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async{
                    this._resultList = await MatchResult.getDatas(); 
                    setState(() {});
                  },
                ),
                ElevatedButton(
                  child: const Text('削除'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () async{
                    var result = await showDialog<int>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: Text('確認',style:TextStyle(fontSize: 12)),
                          content: Text(
                            '全てのデータを削除します。よろしいですか？'
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
                      await MatchResult.deleteData(0);
                      this._initialize();
                    }
                  },
                ),
              ],
            ),
            Flexible(
              child: ListView.builder(
                itemCount: this._resultList.length,
                itemBuilder: (BuildContext context, int index){
                  return (
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                      ),
                      margin: EdgeInsets.only(top: 5),
                      child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded( 
                                  child: Container(
                                    color: Colors.black,
                                    child: Text('$index',style:TextStyle(color: Colors.white)),
                                  )
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(this._resultList[index].myName == null ? "" : this._resultList[index].myName),
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 0 ? 
                                        this._getMyPoint(this._gameResult[index][0].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 1 ? 
                                        this._getMyPoint(this._gameResult[index][1].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 2 ? 
                                        this._getMyPoint(this._gameResult[index][2].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 3 ? 
                                        this._getMyPoint(this._gameResult[index][3].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),right:BorderSide(color:Colors.grey)),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 4 ? 
                                        this._getMyPoint(this._gameResult[index][4].toString())
                                        : ""
                                    )
                                ),
                                Expanded(
                                  child: 
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(right:BorderSide(color:Colors.red)),
                                      ),
                                      child: 
                                        Text(
                                          this._resultList[index].myMatchPoint == null ?
                                            ""
                                            : this._resultList[index].myMatchPoint.toString()
                                          ,style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold,)
                                          ,textAlign: TextAlign.center,
                                        )
                                    ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(border:Border.all(color:Colors.grey)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  child: Text(this._resultList[index].yourName == null ? "" : this._resultList[index].yourName),
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 0 ? 
                                        this._getYourPoint(this._gameResult[index][0].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 1 ? 
                                        this._getYourPoint(this._gameResult[index][1].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 2 ? 
                                        this._getYourPoint(this._gameResult[index][2].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 3 ? 
                                        this._getYourPoint(this._gameResult[index][3].toString())
                                        : ""
                                    )
                                ),
                                Container(
                                  width: 25,
                                  decoration: BoxDecoration(
                                    border: Border(left: BorderSide(color: Colors.grey),right:BorderSide(color:Colors.grey)),
                                  ),
                                  child: 
                                    Text(
                                      this._gameResult[index].length > 4 ? 
                                        this._getYourPoint(this._gameResult[index][4].toString())
                                        : ""
                                    )
                                ),
                                Expanded(
                                  child:
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(right:BorderSide(color:Colors.red)),
                                      ),
                                      child: 
                                        Text(
                                          this._resultList[index].youMatchPoint == null ?
                                            ""
                                            : this._resultList[index].youMatchPoint.toString()
                                          ,textAlign: TextAlign.center
                                          ,style: TextStyle(color: Colors.black, fontWeight:FontWeight.bold,),
                                        )
                                    ),
                                ),
                              ],
                            ),
                          ],
                        )
                    )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}