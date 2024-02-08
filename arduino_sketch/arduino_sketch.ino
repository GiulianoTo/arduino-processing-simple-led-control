#define BUTTON_PIN 2

int lastButtonState = LOW;

void setup() {
  Serial.begin(115200);
  pinMode(LED_BUILTIN, OUTPUT);
  pinMode(BUTTON_PIN, INPUT);
}

void loop() {
  int buttonState = digitalRead(BUTTON_PIN);
  if (buttonState != lastButtonState && buttonState == HIGH) {
    Serial.println("on");
  }
  lastButtonState = buttonState;

  if (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    digitalWrite(LED_BUILTIN, command == "on");
  }
  delay(50);
}
