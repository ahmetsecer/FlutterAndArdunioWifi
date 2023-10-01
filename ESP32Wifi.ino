#include <WiFi.h>

const char* ssid = "YourWiFiSSID"; // Wi-Fi ağ adınız
const char* password = "YourWiFiPassword"; // Wi-Fi şifreniz

WiFiServer server(80);

void setup() {
  Serial.begin(115200);
  delay(1000);

  // Wi-Fi bağlantısını başlatın
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Wi-Fi bağlantısı kuruluyor...");
  }
  Serial.println("Bağlantı başarılı! IP adresi: " + WiFi.localIP().toString());

  // Sunucuyu başlatın
  server.begin();
}

void loop() {
  // Bağlantı bekleme ve istemciyi kabul etme
  WiFiClient client = server.available();
  if (!client) {
    return;
  }

  // İstemciden gelen veriyi okuma
  while (client.connected()) {
    if (client.available()) {
      String command = client.readStringUntil('\n');
      command.trim();
      
      // İstemciden gelen komutları işleyin
      if (command == "ON") {
        // LED'i aç
        // digitalWrite(LED_PIN, HIGH);
      } else if (command == "OFF") {
        // LED'i kapat
        // digitalWrite(LED_PIN, LOW);
      }
    }
  }
}
