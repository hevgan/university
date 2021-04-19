//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

#include <Wire.h>
//slave 
void requestEvent() {
   
  int sensorValue = analogRead(A0);
  if (sensorValue > 255) {
    Wire.write(sensorValue/255);
    Wire.write(sensorValue - 256);
  } else {
    Wire.write(0);
    Wire.write(sensorValue - 256);
  }
}

void setup() {
   Wire.begin(9);

  	
}

void loop() {
  Wire.onRequest(requestEvent); 
}


