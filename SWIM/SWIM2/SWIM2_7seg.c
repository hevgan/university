//MACIEJ ADRYAN 
//PATRYK BOGUSKI
//PATRYK BARTKOWIAK 

#define pinA 0
#define pinB 1
#define pinC 2
#define pinD 3
#define pinE 4
#define pinF 5
#define pinG 6
#define pinH 7
#define D1 8
#define D2 9
#define D3 10
#define D4 11
#define DELAYTIME 10



// the setup routine runs once when you press reset:
void setup() { 

  // initialize the digital pins as outputs.
  pinMode(pinA, OUTPUT);     
  pinMode(pinB, OUTPUT);     
  pinMode(pinC, OUTPUT);     
  pinMode(pinD, OUTPUT);     
  pinMode(pinE, OUTPUT);     
  pinMode(pinF, OUTPUT);     
  pinMode(pinG, OUTPUT);   
  pinMode(pinH, OUTPUT);
  
  pinMode(D1, OUTPUT);  
  pinMode(D2, OUTPUT);  
  pinMode(D3, OUTPUT);  
  pinMode(D4, OUTPUT); 

}

// the loop routine runs over and over again forever:
void loop() {

 	changeDisplay(7312);

}
void changeDisplay(int number){
  
  
  
  byte D=number%10;
  number/=10;
  byte C=number%10;
  number/=10;
  byte B=number%10;
  number/=10;
  byte A= number%10;
  
  
  uint8_t array[4] = {D4,D3,D2,D1};
  byte digits[4] = {A,B,C,D};
  byte current_digit;
  
  for(int i = 0; i<4; i++){
  
    uint8_t which = array[i];
    current_digit = digits[i];
    
    //otworz kontrole pinu
    digitalWrite(which, HIGH);
    
     
    //resetowanie bo cos sie psuje na tych pinach
    digitalWrite(pinA,LOW);
    digitalWrite(pinB,LOW);
    digitalWrite(pinC,LOW);
    digitalWrite(pinD,LOW);
    digitalWrite(pinE,LOW);
    digitalWrite(pinF,LOW);
    digitalWrite(pinG,LOW);


    
    //ustawianie segmentow w zaleznosci od tego czy liczba ma zapalony dany segment
        
    //A     
    if(current_digit == 1 || current_digit == 4 )
    digitalWrite(pinA,HIGH);
    
    //B 
    if(current_digit == 5 || current_digit == 6)
    digitalWrite(pinB,HIGH);

    //C 
    if(current_digit ==2)
    digitalWrite(pinC,HIGH);
    
    //D
    if(current_digit == 1 || current_digit ==4  || current_digit==7)
    digitalWrite(pinD,HIGH);
    
    //E
    if(current_digit == 1 || current_digit ==3 || current_digit == 4 || current_digit==5 || current_digit==7)
    digitalWrite(pinE,HIGH);
    
    //F
    if(current_digit == 1 || current_digit == 2 || current_digit==3 || current_digit ==7)
    digitalWrite(pinF,HIGH);
    
    //G
    if (current_digit==0 || current_digit==1 || current_digit ==7)
    digitalWrite(pinG,HIGH);
    
    //delay zeby sie nie rozjezdzalo
    int myTime = millis();
    
    while(millis()-myTime<DELAYTIME){
    
    }
    
    //zamknij kontrole pinu
    digitalWrite(which, LOW);

    
    
    
  }

}

