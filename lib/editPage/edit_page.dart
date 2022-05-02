
import 'package:flutter/material.dart';
import 'package:dev_app/db/MatchResult.dart';
import 'dart:convert';

class EditPage extends StatelessWidget {
  EditPage({Key? key, required this.recId}) : super(key: key);
  int recId = 0;
  String _myName = "";
  var _yourName = "";
  var _myMatchPoint = "";
  var _youMatchPoint = "";
  List<String> myPoints = [];
  List<String> youPoints = [];
  final TextEditingController _myNameController = TextEditingController();
  final TextEditingController _yourNameController = TextEditingController();
  final TextEditingController _myMatchController = TextEditingController();
  final TextEditingController _yourMatchController = TextEditingController();
  final TextEditingController _setOneMyPointController = TextEditingController();
  final TextEditingController _setOneYouPointController = TextEditingController();
  final TextEditingController _setTwoMyPointController = TextEditingController();
  final TextEditingController _setTwoYouPointController = TextEditingController();
  final TextEditingController _setThreeMyPointController = TextEditingController();
  final TextEditingController _setThreeYouPointController = TextEditingController();
  final TextEditingController _setFourMyPointController = TextEditingController();
  final TextEditingController _setFourYouPointController = TextEditingController();
  final TextEditingController _setFiveMyPointController = TextEditingController();
  final TextEditingController _setFiveYouPointController = TextEditingController();


  @override
  Widget build(BuildContext context){
    getInitialData();
    return Scaffold(
      appBar:AppBar(
        title:const Text('編集'),
      ),
      body: SingleChildScrollView(scrollDirection: Axis.vertical, child: Container(
        alignment: Alignment.center,
        child:Column(
          children:[
            getRow1(),
            getRow2(),
            Container(alignment:Alignment.bottomLeft ,child:const Text('得点：',style:TextStyle(fontSize:20,fontWeight: FontWeight.bold))),
            getRow3(_setOneMyPointController,_setOneYouPointController),
            getRow3(_setTwoMyPointController,_setTwoYouPointController),
            getRow3(_setThreeMyPointController,_setThreeYouPointController),
            getRow3(_setFourMyPointController,_setFourYouPointController),
            getRow3(_setFiveMyPointController,_setFiveYouPointController),
            ElevatedButton(child:const Text('保存する'),onPressed: (){
              _updateData();
              Navigator.pop(context);
            }),
            ElevatedButton(child:const Text('このデータを削除する'),onPressed: (){
              _deleteData();
              Navigator.pop(context);
            }),
          ],
        ),
      ),),
    );
  }

  Widget getRow1(){
    return Row(
      children:[
        Container(alignment:Alignment.center,width:100 ,child:const Text('名前：',style:TextStyle(fontSize:20,fontWeight: FontWeight.bold))),
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "自分の名前を入力"
            ),
            controller: _myNameController,
          ),
        ),
        Container(alignment: Alignment.center, width: 30 ,child:const Text(' - ')),
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "相手の名前を入力"
            ),
            controller: _yourNameController,
          ),
        ),
      ],
    );
  }
  
  Widget getRow2(){
    return Row(
      children:[
        Container(alignment:Alignment.center,width:100 ,child:const Text('セット数：',style:TextStyle(fontSize:20,fontWeight: FontWeight.bold))),
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "セットポイント自分"
            ),
            controller: _myMatchController,
          ),
        ),
        Container(alignment: Alignment.center, width: 30 ,child:const Text(' - ')),
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "セットポイント相手"
            ),
            controller: _yourMatchController,
          ),
        ),
      ],
    );
  }
  
  Widget getRow3(var controller1, var controller2){
    return Row(
      children:[
        Container(alignment:Alignment.center,width: 100 ,child:const Text('')),
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "0"
            ),
            controller: controller1,
          ),
        ),
        Container(alignment: Alignment.center, width: 30 ,child:const Text(' - ')),
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "0"
            ),
            controller: controller2,
          ),
        ),
      ],
    );
  }

  void getInitialData() async{
    List<MatchResult> list = await MatchResult.getDatasFromRecId(recId);
    _myName = list[0].myName;
    _yourName = list[0].yourName;
    _myMatchPoint = list[0].myMatchPoint.toString();
    _youMatchPoint = list[0].youMatchPoint.toString();
    dynamic json = jsonDecode(list[0].gameResult);
    myPoints.clear();
    youPoints.clear();
    for(int i = 0; i < json.length; i++){
      List<String> datas = json[i].toString().split('-');
      myPoints.add(datas[0]);
      youPoints.add(datas[1]);
    }

    // テキストボックス初期化
    _myNameController.text = _myName;
    _yourNameController.text = _yourName;
    _myMatchController.text = _myMatchPoint;
    _yourMatchController.text = _youMatchPoint;
    _setOneMyPointController.text = myPoints.isNotEmpty ? myPoints[0] : "";
    _setOneYouPointController.text = myPoints.isNotEmpty ? youPoints[0] : "";
    _setTwoMyPointController.text = myPoints.length > 1 ? myPoints[1] : "";
    _setTwoYouPointController.text = myPoints.length > 1 ? youPoints[1] : "";
    _setThreeMyPointController.text = myPoints.length > 2 ? myPoints[2] : "";
    _setThreeYouPointController.text = myPoints.length > 2 ? youPoints[2] : "";
    _setFourMyPointController.text = myPoints.length > 3 ? myPoints[3] : "";
    _setFourYouPointController.text = myPoints.length > 3 ? youPoints[3] : "";
    _setFiveMyPointController.text = myPoints.length > 4 ? myPoints[4] : "";
    _setFiveYouPointController.text = myPoints.length > 4 ? youPoints[4] : "";
  }

  void _updateData() async{
    List<String> _list = [];
    _list.add(_setOneMyPointController.text+'-'+_setOneYouPointController.text);
    _list.add(_setTwoMyPointController.text+'-'+_setTwoYouPointController.text);
    _list.add(_setThreeMyPointController.text+'-'+_setThreeYouPointController.text);
    _list.add(_setFourMyPointController.text+'-'+_setFourYouPointController.text);
    _list.add(_setFiveMyPointController.text+'-'+_setFiveYouPointController.text);
    String _jsonGameResult = jsonEncode(_list);
    MatchResult _data = MatchResult(
      recId: recId,
      myMatchPoint: int.parse(_myMatchController.text)
      ,youMatchPoint: int.parse(_yourMatchController.text)
      ,myName: _myNameController.text
      ,yourName: _yourNameController.text
      ,gameResult: _jsonGameResult
    );
    await MatchResult.insertData(_data);
  }

  void _deleteData() async{
    await MatchResult.deleteData(recId);
  }
}
