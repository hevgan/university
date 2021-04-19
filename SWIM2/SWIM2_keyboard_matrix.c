//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

void setup()
{  
  
  //input and output 
  pinMode(0, OUTPUT);
  pinMode(1, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);
  pinMode(6, INPUT_PULLUP);
  pinMode(7, INPUT_PULLUP);
  
  
  //diodes
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(11, OUTPUT);
}

void loop()
{ 
  digitalWrite(8, 0);
  digitalWrite(9, 0);
  digitalWrite(10, 0);
  digitalWrite(11, 0);
  
  // column ABCD
  digitalWrite(0, 0);
  digitalWrite(1, 1);
  digitalWrite(2, 1);
  digitalWrite(3, 1);  
  if (digitalRead(7) == 0) 
  {
    digitalWrite(9, 1);
    digitalWrite(11, 1);
  }
  if (digitalRead(6) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(9, 1);
    digitalWrite(11, 1);
  }
  if (digitalRead(5) == 0) 
  {
    digitalWrite(10, 1);
    digitalWrite(11, 1);
  }
  if (digitalRead(4) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(10, 1);
    digitalWrite(11, 1);
  }
  // column 369#
  digitalWrite(0, 1);
  digitalWrite(1, 0);
  digitalWrite(2, 1);
  digitalWrite(3, 1);  
  if (digitalRead(7) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(9, 1);
  }
  if (digitalRead(6) == 0) 
  {
    digitalWrite(9, 1);
    digitalWrite(10, 1);
  }
  if (digitalRead(5) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(11, 1);
  }
  if (digitalRead(4) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(9, 1);
    digitalWrite(10, 1);
    digitalWrite(11, 1);
  }
  // column 2580
  digitalWrite(0, 1);
  digitalWrite(1, 1);
  digitalWrite(2, 0);
  digitalWrite(3, 1);  
  if (digitalRead(7) == 0) 
  {
    digitalWrite(9, 1);
  }
  if (digitalRead(6) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(10, 1);
  }
  if (digitalRead(5) == 0) 
  {
    digitalWrite(11, 1);
  }
  if (digitalRead(4) == 0) 
  {
  }
  // column 147*
  digitalWrite(0, 1);
  digitalWrite(1, 1);
  digitalWrite(2, 1);
  digitalWrite(3, 0);  
  if (digitalRead(7) == 0) 
  {
    digitalWrite(8, 1);
  }
  if (digitalRead(6) == 0) 
  {
    digitalWrite(10, 1);
  }
  if (digitalRead(5) == 0) 
  {
    digitalWrite(8, 1);
    digitalWrite(9, 1);
    digitalWrite(10, 1);
  }
  if (digitalRead(4) == 0) 
  {
    digitalWrite(9, 1);
    digitalWrite(10, 1);
    digitalWrite(11, 1);
  }
}