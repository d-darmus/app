
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
  void _initialize() async{
    this._resultList = await MatchResult.getDatas(); 
    try{
      setState(() {});
    } catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    this._initialize();
    return Scaffold(
      appBar: AppBar(
        title: Text("試合結果"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            Flexible(
              child: ListView.builder(
                itemCount: this._resultList.length,
                itemBuilder: (BuildContext context, int index){
                  return (
                    Text(
                      "No$index"
                      + " "+this._resultList[index].myName +" vs "+ this._resultList[index].yourName
                      +" "+this._resultList[index].gameResult
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