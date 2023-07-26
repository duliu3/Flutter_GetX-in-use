import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

import 'main.dart';

class WebSocketButtons extends StatefulWidget {
  final String url;

  const WebSocketButtons({required this.url});

  @override
  _WebSocketButtonsState createState() => _WebSocketButtonsState();
}
class _WebSocketButtonsState extends State<WebSocketButtons> {
  bool _isConnecting = false;
  bool _isConnected = false;
  String _message = '';
  final _messages = <String>[];
  late IOWebSocketChannel _channel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        RestartButton(),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isConnecting ? null : _isConnected ? _disconnect : _connect,
          child: _isConnecting
              ? CircularProgressIndicator()
              : Text(_isConnected ? 'Connected' : 'ReConnect'),
        ),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: _isConnected ? _sendMessage : null,
          child: Text('Send Message'),
        ),
        SizedBox(height: 16),
        TextField(
          enabled: _isConnected,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter message',
          ),
          onChanged: (value) => setState(() => _message = value),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: _messages.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(_messages[index]),
            ),
          ),
        ),
      ],
    );
  }

  void _connect() async {
    setState(() {
      _isConnecting = true;
      _messages.insert(0, "Connecting...");
    });

    try {
      _channel = IOWebSocketChannel.connect(widget.url);
      _channel.stream.listen((message) {
        setState(() {
          _messages.insert(0, "Receive: $message");
        });
        print("Websocket Message Received $message");
        if (message == 'PING') {
          _channel.sink.add('PONG');
          print("Websocket Message Send PONG");
          _messages.insert(0, "Send: PONG");
        }
      });
      setState(() {
        _isConnected = true;
        _messages.insert(0, "Connected.");
      });
      print('WebSocket connection established.');
    } catch (e) {
      setState(() {
        _isConnected = false;
        _messages.insert(0, "Failed to establish WebSocket connection.");
      });
    } finally {
      setState(() {
        _isConnecting = false;
      });
    }
  }

  void _disconnect() {
    setState(() {
      _isConnected = false;
      _messages.insert(0, "Disconnected.");
    });
    _channel.sink.close();
  }

  void _sendMessage() {
    if (_message.isNotEmpty) {
      setState(() {
        _messages.insert(0, "Send: $_message");
      });
      _channel.sink.add(_message);
      setState(() {
        _message = '';
      });
    }
  }
}
