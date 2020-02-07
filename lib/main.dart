import 'package:flutter_slidable_list_view/flutter_slidable_list_view.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Checking'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<int> data = List();

  @override
  void initState() {
    super.initState();
    data = List.generate(20, (index) {
      return index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Container(
        child: SlideListView(

          itemBuilder: (bc, index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: <Widget>[
                    Text('child ${data[index]}'),
                    RaisedButton(
                      child: Text('button ${data[index]}'),
                      onPressed: () {
                        print('button click ${data[index]}');
                      },
                    )
                  ],
                ),
              ),
              onTap: () {
                print('tap ${data[index]}');
              },
              behavior: HitTestBehavior.translucent,
            );
          },

          actionWidgetDelegate:
          ActionWidgetDelegate(2, (actionIndex, listIndex) {
            if (actionIndex == 0) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[Icon(Icons.delete), Text('delete')],
              );
            } else {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  listIndex > 5 ? Icon(Icons.close) : Icon(Icons.adjust),
                  Text('close')
                ],
              );
            }
          }, (int indexInList, int index, BaseSlideItem item) {
            if (index == 0) {
              item.remove();
            } else {
              item.close();
            }
          }, [Colors.redAccent, Colors.blueAccent]),
          dataList: data,
          refreshCallback: () async {
            await Future.delayed(Duration(seconds: 2));
            return;
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
