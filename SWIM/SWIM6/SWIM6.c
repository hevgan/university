//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

#include <LiquidCrystal.h>

LiquidCrystal lcd(8, 9, 10, 11, 12, 13);
const int col = 16;
const int row = 2;
int x = 0;
int y = 0;
int analogPin1 = A0;
int analogPin2 = A1;

void setup() {

  lcd.begin(col, row);

  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);

  attachInterrupt(digitalPinToInterrupt(2), handleADC_1, FALLING);
  attachInterrupt(digitalPinToInterrupt(3), handleADC_2, FALLING);

}

void displayWithSymbols(float value, int which) {

  lcd.setCursor(x, y + which);
  lcd.print("A");
  lcd.print(which);
  lcd.print(" U = ");
  lcd.print(value);
  lcd.print(" V");

}

void loop() {}

void handleADC_1() {
  //lcd.clear();	
  int ADC_1 = analogRead(analogPin1);
  float U_1 = (ADC_1 * 5.0) / 1023.0;
  displayWithSymbols(U_1, 0);
}

void handleADC_2() {
  //lcd.clear();	
  int ADC_2 = analogRead(analogPin2);
  float U_2 = (ADC_2 * 5.0) / 1023.0;
  displayWithSymbols(U_2, 1);
}