
import 'dart:convert';
import 'package:dev_app/editPage/edit_page.dart';
import 'package:dev_app/db/MatchResult.dart';
import 'package:flutter/material.dart';

class MatchResultPage extends StatefulWidget {
  const MatchResultPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _MatchResultPage();
  }
}

class _MatchResultPage extends State<MatchResultPage> {
  static const double boxSize = 30;
  List<MatchResult> _resultList = [];
  List<dynamic> gameResult = [];
  void _initialize() async{
    _resultList = await MatchResult.getDatas();
    _convertGameResultJson(); 
    try{
      setState(() {});
    } catch(e){
      print(e);
    }
  }
  void _convertGameResultJson(){
    gameResult.clear();
    for( MatchResult match in _resultList){
      gameResult.add(jsonDecode(match.gameResult));
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
    _initialize();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _noDataMessage(),
            Flexible(
              child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (BuildContext context, int index){
                  return _matchDataWidget(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noDataMessage(){
    if(_resultList.isEmpty){
      return Container(
        alignment: Alignment.center,
        child:const Text('試合結果がありません。')
      );
    }else{
      return const Text('');
    }
  }
  
  Widget _matchDataWidget(int index){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children:[
        headerBarRow(index),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Container(
            alignment: Alignment.center,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:[
                dataBox(index),
                Container(alignment: Alignment.center,width:boxSize*2,height:boxSize*2,child:editButton(index),color:Colors.black12),
              ],
            )),
        ),
      ],
    );
  }

  static Widget headerBarRow(int index){
    int num = index + 1;
    return Container(color:Colors.black87, child: Row(
      mainAxisSize: MainAxisSize.max,
      children:[
        Container(alignment: Alignment.center,height:boxSize,child:Text('No. $num',style:const TextStyle(color:Colors.white))),
      ],
    ));
  }

  Widget dataBox(int index){
    return Column(
      children:[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize*3,height:boxSize,
              child: Text(_resultList[index].myName.isEmpty ? "" : _resultList[index].myName),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 0 ? _getMyPoint(gameResult[index][0].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 1 ? _getMyPoint(gameResult[index][1].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 2 ? _getMyPoint(gameResult[index][2].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 3 ? _getMyPoint(gameResult[index][3].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 4 ? _getMyPoint(gameResult[index][4].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize*2,height: boxSize,
              child: Text(_resultList[index].myMatchPoint.toString(),style:const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize*3,height:boxSize,
              child: Text(_resultList[index].yourName.isEmpty ? "" : _resultList[index].yourName),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 0 ? _getYourPoint(gameResult[index][0].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 1 ? _getYourPoint(gameResult[index][1].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 2 ? _getYourPoint(gameResult[index][2].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 3 ? _getYourPoint(gameResult[index][3].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize,height: boxSize,
              child: Text(gameResult[index].length > 4 ? _getYourPoint(gameResult[index][4].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: boxSize*2,height: boxSize,
              child: Text(_resultList[index].youMatchPoint.toString(),style:const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }

  Widget editButton(int index){
    return ElevatedButton(
      child: const Text('編集'),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder:(context)=>EditPage(recId:_resultList[index].recId)
        ));
      },
    );
  }
}