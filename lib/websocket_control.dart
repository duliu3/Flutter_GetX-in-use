import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/io.dart';
import 'main.dart';

class WebSocketPage extends StatefulWidget {
  final String url;

  const WebSocketPage({required this.url});

  @override
  _WebSocketPageState createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  bool _isConnecting = false;
  bool _isConnected = false;
  String _message = '';
  final _messages = <String>[];
  late IOWebSocketChannel _channel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Go Back'),
            ),
            const SizedBox(width: 20),
            RestartButton(),
          ],
        ),
        Column(
          children: [
            ElevatedButton(
              onPressed: _isConnecting
                  ? null
                  : _isConnected
                      ? _disconnect
                      : _connect,
              child: _isConnecting
                  ? const CircularProgressIndicator()
                  : Text(_isConnected ? 'Connected' : 'ReConnect'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isConnected ? _sendMessage : null,
              child: const Text('Send Message'),
            ),
            Material(
              child: TextField(
                enabled: _isConnected,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter message',
                ),
                onChanged: (value) => setState(() => _message = value),
              ),
            ),
            // Expended(
            //   child: ListView.builder(
            //       itemCount: _messages.length,
            //       itemBuilder: (context, index) => ListTile(
            //         title: Text(_messages[index]),
            //       ),
            //     ),
            // ),
          ],
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

class RestartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        onPressed: () {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          // Future.delayed(Duration.zero, () {
          //   runApp(MyApp());
          // });
        },
        child: Text('Exit'),
      ),
    );
  }
}
