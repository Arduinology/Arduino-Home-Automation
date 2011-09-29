int SER_Pin = 8;   //pin 15 on the 75HC595
int RCLK_Pin = 9;  //pin 12 on the 75HC595
int SRCLK_Pin = 10; //pin 10 on the 75HC595
#define number_of_74hc595s 1 
#define numOfRegisterPins number_of_74hc595s * 8
boolean registers[numOfRegisterPins];

int ledPin = 2;
int ledPin2 = 7;
int relayPin = 8;
int readPin = 12;
int usbnumber;
int writeArray = 0;
int i = 0;
int homeArray[2];
char serialString[255];
char pinArray[] = {0,0,0,0,0,0,0,0,ledPin, ledPin2};
int srIndex = 0;
int serOutIndx=0;
int length = 0;
int arraySet = 0;
int arrayMod = 0;
int arrayValue;
int pinArrayVal;
void setup() {
    pinMode(SER_Pin, OUTPUT);
    pinMode(RCLK_Pin, OUTPUT);
    pinMode(SRCLK_Pin, OUTPUT);
    pinMode(ledPin, OUTPUT);
    pinMode(ledPin2, OUTPUT);
    pinMode(relayPin, OUTPUT);
    pinMode(readPin, INPUT);
    Serial.begin(9600);
    clearRegisters();
    writeRegisters();
}
void clearRegisters(){
  for(int i = numOfRegisterPins - 1; i >=  0; i--){
     registers[i] = LOW;
  }
} 
void writeRegisters(){

  digitalWrite(RCLK_Pin, LOW);

  for(int i = numOfRegisterPins - 1; i >=  0; i--){
    digitalWrite(SRCLK_Pin, LOW);

    int val = registers[i];

    digitalWrite(SER_Pin, val);
    digitalWrite(SRCLK_Pin, HIGH);

  }
  digitalWrite(RCLK_Pin, HIGH);
}
void setRegisterPin(int index, int value){
  registers[index] = value;
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
    Serial.print(buf[i], DEC);
  }
}
void automation1(int pin_id, int value){
    digitalWrite(pinArray[pin_id], value);
    registers[pin_id] = value;
}
void loop() {
  char buf[16];
  int pin_id, value;
  read_line(buf, '\n', 16);
  sscanf(buf, "%d=%d", &pin_id, &value);
  Serial.print(pin_id);
  automation1(pin_id, value);
  writeRegisters();
}

