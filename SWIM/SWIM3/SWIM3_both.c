//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

// ARDUINO UNO posiada sprzętowy interfejs komunikacji 
// szeregowej USART wyprowadzony na pinach 0 i 1 płytki 
// (wykorzystywany również do komunikacji z komputerem 
// za pomocą złącza USB).
//
// SoftwareSerial.h - biblioteka opracowana w celu 
// umożliwienia komunikacji szeregowej na innych pinach 
// cyfrowych ARDUINO UNO (programowy interfejs transmisji 
// szeregowej USART).
// 
// SoftwareSerial(rxPin, txPin, inverse_logic) - służy do
// tworzenia programowego interfejsu USART. Parametrami są
// numery pinów RX (odbiór danych) i TX (wysyłanie danych)
// oraz inverse_logic (zmian logiki przesyłanych danych), 
// którego wartość należy pozostawić daomyślną. 
//
// begin(speed) - ustawienie prędkości transmisji. Dla interfejsu 
// programowego nazwa.begin(2400). Dla interfejsu sprzętowego
// Serial.begin(9600).
//
// available() - zwraca liczbę bajtów (znaków) możliwych
// do odczytania z bufora (max 64).
//
// read() - zwraca odebrany bajt (znak).
//
// write(data) - wysłanie bajtu (znaku).
// 
// print(data) / println(data) - wysyłanie danych.

#include <SoftwareSerial.h>
#define rx 8 
#define tx 9

SoftwareSerial s = SoftwareSerial(rx, tx);

void setup(){
  pinMode(7, INPUT_PULLUP);
  pinMode(rx, INPUT);
  pinMode(tx, OUTPUT);
  pinMode(13, OUTPUT);
  s.begin(2400);

  Serial.begin(9600); //Ustawienie prędkości transmisji
  
}
void loop() {
  s.write((digitalRead(7) == LOW) ? '1' : '0');
  if(s.available()){
      digitalWrite(13, s.read() == '1' ? HIGH : LOW);

  
  }
  
}