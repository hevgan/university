//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

#include <SPI.h>
 #define CLK 13
 #define MOSI 11
 #define SS1 4
 #define SS2 5
 #define SS3 6
 #define SS4 7
// Pamiętać o ustawieniu właściwego kierunku
// dla zdefiniowanych pinów.
//
// Przesłanie danych do wybranego układu SLAVE
// SS <- 0
// shiftOut(...)
// SS <- 1
//
// shiftOut(pin_danych, pin_zegara, kolejnoćć_bitów, dane)
// przesłanie bajtu "dane" bit po bicie za pomocą pinu
// "pin_danych", w takt zegara "pin_zegara", w kolejności 
// od najmniej znaczącego bitu (LSBFIRST), lub najbardziej
// znaczącego bitu (MSBFIRST).



byte data[10] = {B11111100, B01100000, B11011010, B11110010, B01100110, B10110110, B10111110, B11100000, B11111110, B11110110};

void setup()
{
  // fragment kodu, który wykona raz po uruchomieniu
  // programu.
     Serial.begin(115200); 

     digitalWrite(SS, HIGH); // disable Slave Select

 
  pinMode(SS1, OUTPUT);
  pinMode(SS2, OUTPUT);
  pinMode(SS3, OUTPUT);
  pinMode(SS4, OUTPUT);
  
  pinMode(CLK, OUTPUT);
  pinMode(MOSI, OUTPUT);
	
  //Serial.begin(115200);
   SPI.begin();
     //SPI.setClockDivider(SPI_CLOCK_DIV8);//divide the clock by 8

}

void loop()
{
  int number[4] = {2,1,3,7};
  
  digitalWrite(SS4, LOW);
  shiftOut(MOSI, CLK, LSBFIRST, data[number[0]]);
  digitalWrite(SS4, HIGH);
  
    digitalWrite(SS3, LOW);
  shiftOut(MOSI, CLK, LSBFIRST, data[number[1]]);
  digitalWrite(SS3, HIGH);
  
    digitalWrite(SS2, LOW);
  shiftOut(MOSI, CLK, LSBFIRST, data[number[2]]);
  digitalWrite(SS2, HIGH);
  
    digitalWrite(SS1, LOW);
  shiftOut(MOSI, CLK, LSBFIRST, data[number[3]]);
  digitalWrite(SS1, HIGH);

  
  
}