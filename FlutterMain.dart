import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  _sendCommand(String command) async {
    String ipAddress = "ESP32_IP_ADDRESS"; // ESP32'nin IP adresini buraya ekleyin
    var url = Uri.parse("http://$ipAddress");
    var response = await http.post(url, body: command);

    if (response.statusCode == 200) {
      print("Komut gönderildi: $command");
    } else {
      print("Komut gönderilirken hata oluştu.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ESP32 Kontrol App"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _sendCommand("ON");
              },
              child: Text("LED'i Aç"),
            ),
            ElevatedButton(
              onPressed: () {
                _sendCommand("OFF");
              },
              child: Text("LED'i Kapat"),
            ),
          ],
        ),
      ),
    );
  }
}
