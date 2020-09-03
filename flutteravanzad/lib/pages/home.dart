import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteravanzad/models/band.dart';
import 'package:flutteravanzad/services/socket_service.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [];


  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);

    socketService.socket.on('active-bands', (data) {
      _handleActiveBnads(data);


  setState(() {

  });
      
    });
    super.initState();
  }


  _handleActiveBnads (dynamic data) {
    this.bands = (data as List).map((band) => Band.fromMap(band) ).toList();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    final socketService = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online) ?
            Icon(Icons.check_circle, color: Colors.blue[300],) :
              Icon(Icons.offline_bolt, color: Colors.red[300],)
          )
        ],
        title: Text('BandNmaes', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          
           _showGrap(),

          Expanded(
            child: ListView.builder(
                itemCount: bands.length,
                itemBuilder: (context, index) => _bandTitle(bands[index])
            ),
          ),
        ],
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
    final socketService = Provider.of<SocketService>(context , listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
       
        socketService.socket.emit('delete-band' , {'id' : band.id});
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
          socketService.socket.emit('vote-band' , {'id' : band.id});
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

    final socketService = Provider.of<SocketService>(context , listen: false);
    if( name.length > 1) {
      //agregamos banda

      socketService.socket.emit('add-band' , {'name' : name});


    }
    Navigator.pop(context);
  }

  Widget _showGrap() {

    Map<String, double> dataMap = new Map();

    
    bands.forEach((band) {
      
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
    });


    return Container(
      width: double.infinity,
        height: 200,
        child: PieChart(dataMap: dataMap));
  }
}
