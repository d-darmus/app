
import 'package:flutter/material.dart';
import 'package:dev_app/MyDataModel.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _Page2();
  }
}

class _Page2 extends State<Page2> {
  List<MyDataModel> _mydataModel = [];
  Future<void> _initialize() async {
    _mydataModel = await MyDataModel.getDatas();
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Test2"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '表示',
            ),
            ElevatedButton(
              child: const Text('表示'),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black,
                shape: const StadiumBorder(),
              ),
              onPressed: _initialize,
            ),
            Flexible(
              child: ListView.builder(
                itemCount: _mydataModel.length,
                itemBuilder: (BuildContext context, int index){
                  return (Text("No$index "+_mydataModel[index].id.toString()+" "+_mydataModel[index].text));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}