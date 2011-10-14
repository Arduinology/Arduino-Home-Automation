//__________Include Dependencies____________________//
#include <Ethernet.h>
#include <SPI.h>

//_____________Define Shift Register Variables_______________//
int SER_Pin = 5;   //pin 14 on the 75HC595
int RCLK_Pin = 4;  //pin 12 on the 75HC595
int SRCLK_Pin = 3; //pin 11 on the 75HC595
#define number_of_74hc595s 2
#define numOfRegisterPins number_of_74hc595s * 8
boolean registers[numOfRegisterPins];

//_____________Define Ethernet Variables___________//
byte mac[] = { 0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED };  
byte ip[] = { 192, 168, 1, 202 };    
byte gateway[] = {192,168,1,1};	
byte subnet[] = {255, 255, 255, 0 };
Server server = Server(80);

boolean reading = false;
char buf[16];
char pin_id[5];
char value[5];

//_________PURGE__________________//
int ledPin = 2;
int ledPin2 = 7;
int i = 0;
//char pinArray[] = {0,0,0,0,0,0,0,0,ledPin, ledPin2}; //The problem is here


void setup() {
    SPI.begin();
    Ethernet.begin(mac, ip);
    server.begin();
    pinMode(SER_Pin, OUTPUT);
    pinMode(RCLK_Pin, OUTPUT);
    pinMode(SRCLK_Pin, OUTPUT);
    pinMode(ledPin, OUTPUT);
    pinMode(ledPin2, OUTPUT);
    clearRegisters();
    writeRegisters();
}
void loop() {
  checkForClient(buf);
  //automation1(pin_id, value);
  writeRegisters();
  
}
void clearRegisters(){
  
  for(int i = numOfRegisterPins - 1; i >=  0; i--){
     registers[i] = LOW;
  }
  registers[1] = HIGH;
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
void automation1(char *pin_id, char *value, Client client){
  delay(1);
  client.print("?");
  client.print(*pin_id, DEC);
  //digitalWrite(pinArray[*pin_id-48], *value-48);
  if(atoi(value) == 1){
    registers[atoi(pin_id)] = HIGH;
  } else registers[atoi(pin_id)] = LOW;
}
void checkForClient(char *buf){
  memset(buf, 0, 16);
  int i = 0;
  Client client = server.available();
  if (client) {
    boolean currentLineIsBlank = true;
    boolean sentHeader = false;
    while (client.connected()) {
      if (client.available()) {
        if(!sentHeader){
          // send a standard http response header
          client.println("HTTP/1.1eman 200 OK");
          client.println("Content-Type: text/html");
          client.println();
          sentHeader = true;
        }
        char c = client.read();
        client.print(c);
        if(reading && c == ' ') reading = false;
        if(c == '?') reading = true; //found the ?, begin reading the info
        if(reading){
          buf[i] = c;
          client.print(c, BIN);
          client.println();
          client.print(c, DEC);
          client.println();
          client.print(c);
          client.println("<br/>");
          //client.print(c);
          i++;
        }
        if (c == '\n' && currentLineIsBlank)  break;
        if (c == '\n') {
          currentLineIsBlank = true;
        }
        else if (c != '\r') {
          currentLineIsBlank = false;
        }
      }
    }
    delay(5);
    setValues(buf, client);
    client.println("<br />");
    automation1(pin_id, value, client);
    client.stop();
  } 
}

void setValues(char *buf, Client client){
  if(buf[0] != 0){  
    sscanf(buf, "?%7[a-zA-Z0-9]=%7[a-zA-Z0-9]", pin_id, value);
    client.print(pin_id);
  }
}

