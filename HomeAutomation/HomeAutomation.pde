int ledPin = 2;
int ledPin2 = 7;
int relayPin = 8;
int readPin = 12;
int usbnumber;
int writeArray = 0;
int i = 0;
int homeArray[2];
char serialString[255];
char pinArray[] = {ledPin, ledPin2};
int srIndex = 0;
int serOutIndx=0;
int length = 0;
int arraySet = 0;
int arrayMod = 0;
int arrayValue;
int pinArrayVal;
void setup() {
    pinMode(ledPin, OUTPUT);
    pinMode(ledPin2, OUTPUT);
    pinMode(relayPin, OUTPUT);
    pinMode(readPin, INPUT);
    Serial.begin(9600);
}
void read_line(char *buf, char delimiter, int len){
  for(i=0; i<len;i++){
    while(Serial.available() == 0);
    buf[i] = Serial.read();
    if(buf[i] == delimiter){
      buf[i] = '\0';
      Serial.println();
      return;
    }
    Serial.print(buf[i]);
  }
}
void automation1(int pin_id, int value){
    digitalWrite(pinArray[pin_id], value);
}
void loop() {
  char buf[16];
  int pin_id, value;
  read_line(buf, '\n', 16);
  sscanf(buf, "%d=%d", &pin_id, &value);
  Serial.print(pin_id);
  automation1(pin_id, value);
}

