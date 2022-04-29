
import 'package:flutter/material.dart';
import 'package:dev_app/MatchResult.dart';
import 'dart:convert';

class TokutenbanPage extends StatefulWidget {
  const TokutenbanPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _TokutenbanPage();
  }
}

class _TokutenbanPage extends State<TokutenbanPage> {
  static const double POINT_SIZE_HORIZON = 170;
  static const double POINT_SIZE_VERTICAL = 80;
  bool isHorizon = true;
  int _myPoint = 0;
  int _myMatchPoint = 0;
  int _youPoint = 0;
  int _youMatchPoint = 0;
  String _myName = "";
  String _yourName = "";
  List<String> _gameResult = [];
  final TextEditingController _myNameController = TextEditingController();
  final TextEditingController _yourNameController = TextEditingController();
  bool _isLeftMe = true;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: LayoutBuilder(
        builder:(context, constraints) {
          if (constraints.maxWidth < constraints.maxHeight){
            isHorizon = false;
            return _horizontalLayout(context);
          } else {
            return _horizontalLayout(context);
          }
        },
      ),
    );
  }


  /** ゲーム終了判定 */
  void _isGameOver() async{
    bool _checkresult = true;
    if(11 == this._myPoint && 10 > this._youPoint){
    } else if(11 == this._youPoint && 10 > this._myPoint){
    } else if(11 < this._myPoint || 11 < this._youPoint){
      if(2 == this._myPoint - this._youPoint){
      } else if(2 == this._youPoint - this._myPoint){
      } else {
        _checkresult = false;
      }
    } else {
      _checkresult = false;
    }
    if(_checkresult){
      // ゲーム終了時
      var _result = await showDialog<int>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: const Text('確認',style:TextStyle(fontSize: 12)),
            content: Text('ゲームが終了しました。\nゲーム結果を一時保存します。よろしいですか？\n\n $_myPoint - $_youPoint'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(0),
              ),
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(1),
              ),
            ],
          );
        },
      );
      if(1 == _result){
        setState((){
          if(_myPoint > _youPoint){
            _myMatchPoint++;
          } else {
            _youMatchPoint++;
          }
          if(_isLeftMe){
            _gameResult.add(_myPoint.toString()+'-'+_youPoint.toString());
          } else {
            _gameResult.add(_youPoint.toString()+'-'+_myPoint.toString());
          }
          _myPoint = 0;
          _youPoint = 0;
        });
      }
    }
  }

  /** データ登録 */
  void _registData() async{
    if(!_isLeftMe){
      _isLeftMe = !_isLeftMe;
      String tmp = _myNameController.text;
      _myNameController.text = _yourNameController.text;
      _yourNameController.text = tmp;
      int num = _youMatchPoint;
      _youMatchPoint = _myMatchPoint;
      _myMatchPoint = num;
      num = _youPoint;
      _youPoint = _myPoint;
      _myPoint = num;
    }
    String _jsonGameResult = jsonEncode(this._gameResult);
    MatchResult _data = MatchResult(
      myMatchPoint: this._myMatchPoint
      ,youMatchPoint: this._youMatchPoint
      ,myName: _myNameController.text
      ,yourName: _yourNameController.text
      ,gameResult: _jsonGameResult
    );
    await MatchResult.insertData(_data);
  }

  /** 縦画面のレイアウト */
  Widget _verticalLayout(BuildContext context){
    return Container();
  }

  /** 横画面のレイアウト */
  Widget _horizontalLayout(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:Container(
        color:Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _tokutenBanWidget(),
            _inputNames(),
          ],
        ),
      ),
    );
  }

  /** 入出力エリアWidget */
  Widget _inputNames(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[
        Flexible(
          flex:3,
          child: TextField(
            decoration: const InputDecoration(
              hintText: "自分の名前を入力"
            ),
            controller: _myNameController,
          ),
        ),
        Flexible(
          flex:3,
          child:getGameResult(_gameResult),
        ),
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

  /** 得点版Widget */
  Widget _tokutenBanWidget(){
    double _pointSize = POINT_SIZE_HORIZON;
    if(isHorizon){
      _pointSize = POINT_SIZE_HORIZON;
    } else {
      _pointSize = POINT_SIZE_VERTICAL;
    }

    return Row(
      children: [
        Expanded(
          flex: 3,
          child: GestureDetector(child:Container(
            margin:const EdgeInsets.only(left:4),
            alignment: Alignment.center,
            color: Colors.black, 
            child:Text('$_myPoint',style: TextStyle(color:Colors.white,fontSize:_pointSize)),
            height: MediaQuery.of(context).size.height * 0.62,),
          onTap:(){
            setState((){this._myPoint++;});
            _isGameOver();
          },
          onVerticalDragEnd: (details){
            if(details.primaryVelocity! > 0){
              setState((){ _myPoint > 0 ? _myPoint-- : 0;});
              _isGameOver();
            }else{
              setState((){this._myPoint++;});
              _isGameOver();
            }
          },)
        ),
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Container(
                margin:const EdgeInsets.only(top:0),
                child:TextButton(child:Image.asset('assets/button01.png'),style:TextButton.styleFrom(fixedSize: const Size(200,60),primary: Colors.black),onPressed:(){
                  setState((){
                    _isLeftMe = !_isLeftMe;
                    String tmp = _myNameController.text;
                    _myNameController.text = _yourNameController.text;
                    _yourNameController.text = tmp;
                    int num = _youMatchPoint;
                    _youMatchPoint = _myMatchPoint;
                    _myMatchPoint = num;
                    num = _youPoint;
                    _youPoint = _myPoint;
                    _myPoint = num;
                  });
                })
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,children:[
                Expanded(
                  child: GestureDetector(child:Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(left:4,right:2), color: Colors.black, child:
                    Text('$_myMatchPoint',style:const TextStyle(color:Colors.white,fontSize:90)),
                    height: MediaQuery.of(context).size.height * 0.4,),
                  onTap:(){setState((){this._myMatchPoint++;});},
                  onVerticalDragEnd: (details){
                    if(details.primaryVelocity! > 0){
                      setState((){ _myMatchPoint > 0 ? _myMatchPoint-- : 0; });
                    }else{
                      setState((){this._myMatchPoint++;});
                    }
                  },)
                ),
                Expanded(
                  child:GestureDetector(child:Container(
                    alignment: Alignment.center,
                    margin:const EdgeInsets.only(left:2,right:4), color: Colors.black, child:
                    Text('$_youMatchPoint',style:const TextStyle(color:Colors.white,fontSize:90)),
                    height: MediaQuery.of(context).size.height * 0.4,),
                  onTap: (){setState((){this._youMatchPoint++;});},
                  onVerticalDragEnd: (details){
                    if(details.primaryVelocity! > 0){
                      setState((){ _youMatchPoint > 0 ? _youMatchPoint-- : 0; });
                    }else{
                      setState((){this._youMatchPoint++;});
                    }
                  },)
                ),
              ]),
              Container(
                margin:const EdgeInsets.only(top:10),
                child:TextButton(child:const Text('試合終了',style:TextStyle(color:Colors.white,fontSize:25)),style:TextButton.styleFrom(fixedSize: const Size(120,60),primary: Colors.black),onPressed:(){
                  alertEndMatch(context);
                })
              ),
            ]
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            child:Container(
              margin:const EdgeInsets.only(right:4),
              alignment: Alignment.center,
              color: Colors.black, 
              child:Text('$_youPoint',style: TextStyle(color:Colors.white,fontSize:_pointSize)),
              height: MediaQuery.of(context).size.height * 0.62,),
            onTap:(){
              setState((){this._youPoint++;});
              _isGameOver();
            },
            onVerticalDragEnd: (details){
              if(details.primaryVelocity! > 0){
                setState((){ _youPoint > 0 ? _youPoint-- : 0; });
                _isGameOver();
              }else{
                setState((){this._youPoint++;});
                _isGameOver();
              }
            },
          )
        ),
      ],
    );
  }

  /** アラート */
  void alertEndMatch(BuildContext context) async {
    String _message = 
      "以下の結果を保存します。よろしいですか？\n"
      +_myNameController.text+" "+_yourNameController.text+"\n"
      +_myMatchPoint.toString()+" - "+_youMatchPoint.toString()+"\n";
    if(!_isLeftMe){
      _message = 
        "以下の結果を保存します。よろしいですか？\n"
        +_yourNameController.text+" "+_myNameController.text+"\n"
        +_youMatchPoint.toString()+" - "+_myMatchPoint.toString()+"\n";
    }
    for(String data in _gameResult){
      _message += data+"\n";
    }

    var result = await showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          title: const Text('確認',style:TextStyle(fontSize: 12)),
          content: Text(_message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(0),
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(1),
            ),
          ],
        );
      },
    );
    if(1==result){
      _registData();
      setState((){
        _myPoint = 0;
        _myMatchPoint = 0;
        _youPoint = 0;
        _youMatchPoint = 0;
        _gameResult.clear();
      });
    }
  }

  /** ゲーム結果Wiget */
  Widget getGameResult(List<String> list){
    List<Widget> widgetlist = [];
    if(_isLeftMe){
      for(String data in list){
        List<String> str = data.split('-');
        widgetlist.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Container(alignment: Alignment.center,width:20,child:Text(str[0]),),
            const Text(' - '),
            Container(alignment: Alignment.center,width:20,child:Text(str[1]),),
          ])
        );
      }
    } else {
      for(String data in list){
        List<String> str = data.split('-');
        widgetlist.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
            Container(alignment: Alignment.center,width:20,child:Text(str[1]),),
            const Text(' - '),
            Container(alignment: Alignment.center,width:20,child:Text(str[0]),),
          ])
        );
      }
    }

    return Container(
      width: 100,
      child:Column(
        children:widgetlist,
      )
    );
  }
}