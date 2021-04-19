//MACIEJ ADRYAN 
//PATRYK BOGUSKI 
//PATRYK BARTKOWIAK 


#define interrupt_a 3
#define interrupt_b 2

int vect = -1;   //step size
int pinNum = 13; //starting pin
int dir = 1;     //direction
int *dir_ptr = &dir;
unsigned long myTime;
void setup()
{
    myTime = millis();
    //diodes
    pinMode(13, OUTPUT);
    pinMode(12, OUTPUT);
    pinMode(11, OUTPUT);
    pinMode(10, OUTPUT);
    pinMode(9, OUTPUT);
    pinMode(8, OUTPUT);

    //switches
    pinMode(interrupt_a, INPUT_PULLUP);
    pinMode(interrupt_b, INPUT_PULLUP);

    //async button pressing
    attachInterrupt(digitalPinToInterrupt(interrupt_a), dir_right, FALLING);
    attachInterrupt(digitalPinToInterrupt(interrupt_b), dir_left, FALLING);
}

void changeDir(int *dir, int value)
{
    *dir = value;
}

void loop()
{

    
        //keeping boundaries
        if (pinNum == 14)
            pinNum = 8;
        if (pinNum == 7)
            pinNum = 13;

        //turn diode on and off
        digitalWrite(pinNum, HIGH);
        if (millis() - myTime > 500 || millis() < myTime)
        {
            digitalWrite(pinNum, LOW);

            //change the pin to be lit up
            myTime = millis();
            pinNum += (dir*vect);
           
        }
            

}

void dir_left()
{
    changeDir(dir_ptr, 1);
}
void dir_right()
{
    changeDir(dir_ptr, -1);
}
