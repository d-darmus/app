
import 'package:dev_app/MyDataModel.dart';
import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _Page1();
  }
}

class _Page1 extends State<Page1> {
  int _salary = 0;
  int _payment = 0;
  int _result = 0;
  List<MyDataModel> _mydataModel = [];

  static bool _checkNumber(String str){
    bool result = new RegExp(r'^[0-9]+$').hasMatch(str);
    return result;
  }
  void _reloadDisplay() async{
    initializeDemo();
    setState((){});
    int _listLength = this._mydataModel.length;
    MyDataModel _data = MyDataModel(id: _listLength,text: this._result.toString());
    await MyDataModel.insertData(_data);
  }
  void _deleteAllData() async{
    await MyDataModel.deleteData(0);
  }
  Future<void> initializeDemo() async {
    _mydataModel = await MyDataModel.getDatas();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Test1"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '給料',
            ),
            TextField(
              onChanged: (text){
                if(_checkNumber(text)){
                  this._salary = int.parse(text);
                  this._result = this._salary - this._payment;
                }
              }
            ),
            const Text(
              '支出'
            ),
            TextField(
              onChanged: (text){
                if(_checkNumber(text)){
                  this._payment = int.parse(text);
                  this._result = this._salary - this._payment;
                }
              }
            ),
            const Text(
              '収支',
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(
              child: const Text('登録'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: _reloadDisplay,
            ),
            ElevatedButton(
              child: const Text('削除'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: _deleteAllData,
            ),
          ],
        ),
      ),
    );
  }
}