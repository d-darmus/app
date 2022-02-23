
import 'dart:convert';
import 'package:dev_app/editPage/edit_page.dart';
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
  static const double BOX_SIZE = 30;
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
    _initialize();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                itemCount: this._resultList.length,
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
  
  Widget _matchDataWidget(int index){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children:[
        headerBarRow(index),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child:Container(
          child:Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              dataBox(index),
              Container(alignment: Alignment.center,width:BOX_SIZE*2,height:BOX_SIZE*2,child:editButton(index),color:Colors.black12),
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
        Container(alignment: Alignment.center,height:BOX_SIZE,child:Text('No. $num',style:const TextStyle(color:Colors.white))),
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
              width: BOX_SIZE*3,height:BOX_SIZE,
              child: Text(_resultList[index].myName.isEmpty ? "" : _resultList[index].myName),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 0 ? _getMyPoint(_gameResult[index][0].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 1 ? _getMyPoint(_gameResult[index][1].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 2 ? _getMyPoint(_gameResult[index][2].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 3 ? _getMyPoint(_gameResult[index][3].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 4 ? _getMyPoint(_gameResult[index][4].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE*2,height: BOX_SIZE,
              child: Text(_resultList[index].myMatchPoint.toString(),style:const TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE*3,height:BOX_SIZE,
              child: Text(_resultList[index].yourName.isEmpty ? "" : _resultList[index].yourName),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 0 ? _getYourPoint(_gameResult[index][0].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 1 ? _getYourPoint(_gameResult[index][1].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 2 ? _getYourPoint(_gameResult[index][2].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 3 ? _getYourPoint(_gameResult[index][3].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE,height: BOX_SIZE,
              child: Text(_gameResult[index].length > 4 ? _getYourPoint(_gameResult[index][4].toString()) : ""),
            ),
            Container(
              decoration:const BoxDecoration(border:Border(left:BorderSide(color:Colors.grey),right:BorderSide(color:Colors.grey),bottom:BorderSide(color:Colors.grey))),
              alignment: Alignment.center,
              width: BOX_SIZE*2,height: BOX_SIZE,
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