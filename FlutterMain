import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

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
  FlutterBlue flutterBlue = FlutterBlue.instance;
  BluetoothDevice device;
  BluetoothCharacteristic characteristic;

  @override
  void initState() {
    super.initState();
    _connectToDevice();
  }

  _connectToDevice() async {
    // ESP32'yi bulun
    List<ScanResult> devices = await flutterBlue.scan(timeout: Duration(seconds: 5));
    for (var dev in devices) {
      if (dev.device.name == "YourESP32") { // ESP32'nin adını buraya ekleyin
        device = dev.device;
        break;
      }
    }

    // ESP32 ile bağlantı kurun
    await device.connect();

    // Karakteristiği bulun ve dinlemeye başlayın
    List<BluetoothService> services = await device.discoverServices();
    for (var service in services) {
      for (var char in service.characteristics) {
        if (char.uuid.toString() == "beb5483e-36e1-4688-b7f5-ea07361b26a8") { // Arduino'daki karakteristik UUID'sini buraya ekleyin
          characteristic = char;
          characteristic.setNotifyValue(true);
          characteristic.value.listen((value) {
            // ESP32'den gelen veriyi işleyin
            String data = String.fromCharCodes(value);
            print("ESP32'den gelen veri: $data");
          });
        }
      }
    }
  }

  _sendCommand(String command) {
    // ESP32'ye komut gönderin
    List<int> bytes = utf8.encode(command);
    characteristic.write(bytes);
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
