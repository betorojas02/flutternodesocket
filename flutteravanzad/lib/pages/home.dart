import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteravanzad/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'metallica', votes: 5),
    Band(id: '1', name: 'Queen', votes: 5),
    Band(id: '1', name: 'Herores del silencio', votes: 5),
    Band(id: '1', name: 'Bon jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text('BandNmaes', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, index) => _bandTitle(bands[index])
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewBand();
        },
        elevation: 1,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print(direction);
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
            child: Text('Delete band', style: TextStyle(color: Colors.white),)),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(band.name.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }


  addNewBand() {

    final textController = TextEditingController();

    if(Platform.isAndroid  ){
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text('add'),
                textColor: Colors.blue,
                elevation: 5,
                onPressed: () {
                  addBandToList(textController.text);
                },
              )
            ],
          );

        },
      );
    }else{

      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text('New band name:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('add'),
                onPressed: () {
                  addBandToList(textController.text);
                },
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dissmiss'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }


  }

  void addBandToList(String name) {
    if( name.length > 1) {
      //agregamos banda
      this.bands.add(new Band(id: DateTime.now().toString(), name: name , votes: 0 ));
      setState(() {

      });
    }
    Navigator.pop(context);
  }
}
