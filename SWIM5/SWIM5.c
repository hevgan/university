//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

#include <LiquidCrystal.h>

#define WAIT_TIME 200

LiquidCrystal lcd(8, 9, 10, 11, 12, 13);
byte smiley[8] = {
  B00000,
  B10001,
  B00000,
  B00000,
  B10001,
  B01110,
  B00000,
};

int x = 0;
int y = 0;


void setup() {
  lcd.createChar(0, smiley);
  lcd.begin(16, 2);
  Serial.begin(9600);

  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);

}

void loop() {
  lcd.setCursor(x, y);
  lcd.write(byte(0));
  if (digitalRead(2) == LOW) {
    lcd.clear();
    delay(WAIT_TIME);
    if (x - 1 >= 0)
      x -= 1;
  }
  if (digitalRead(3) == LOW) {
    lcd.clear();
    delay(WAIT_TIME);
    if (x + 1 < 16)
      x += 1;
  }
  if (digitalRead(4) == LOW) {
    lcd.clear();
    delay(WAIT_TIME);
    if (y - 1 >= 0)
      y -= 1;
  }
  if (digitalRead(5) == LOW) {
    lcd.clear();
    if (y + 1 < 2)
      y += 1;
    delay(WAIT_TIME);
  }

}