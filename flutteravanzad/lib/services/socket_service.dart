import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;

  IO.Socket _socket;

  IO.Socket get socket => this._socket;
  ServerStatus get serverStatus => this._serverStatus;

  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    this._socket = IO.io('http://192.168.31.254:3000/', {
      'transports': ['websocket'],
      'autoConnect': true,
//      'extraHeaders': {'foo': 'bar'} // optional
    });
    this._socket.on('connect', (_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
//    socket.on('event', (data) => print(data));
//    socket.on('nuevo-mensaje', (payload) {
//
//      print('emitir-mensaje: ${payload}');
//    });
//    socket.on('fromServer', (_) => print(_));



  }
}
