//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

#include <Wire.h>
//Master

void setup() {
  Wire.begin();
  Serial.begin(9600);
}

void loop() {
    delay(1000);
 	Wire.requestFrom(9, sizeof(int));
  	int temp = 0;
  	double tempDec = 0.0;
  
  		byte tmp = Wire.read();
  		byte tmp1 = Wire.read();
    	temp = (int)(tmp << 8) | (int)(tmp1 );
    	tempDec = (((double)temp*5.0)/1024 - 0.4971)*100.0;
    	Serial.print(tempDec);
        Serial.print("*C \n");


}