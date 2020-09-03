import 'package:flutter/material.dart';
import 'package:flutteravanzad/services/socket_service.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  get nombre => null;

  get mensaje => null;

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context);


    return Scaffold(
      body: Center(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('ServerStatus: ${socketService.serverStatus}')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child:Icon(Icons.message),
      ),
    );
  }
}
