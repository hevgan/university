#define _CRT_SECURE_NO_WARNINGS
#define _USE_MATH_DEFINES

#include<stdio.h>
#include <cmath>
#include <conio.h>
#include <iostream>

using namespace std;
struct Measurements {
	double g_x;
	double g_y;
	double g_z;

	Measurements() {

	}

	Measurements(double g_x, double g_y, double g_z) {
		this->g_x = g_x;
		this->g_y = g_y;
		this->g_z = g_z;
	}



};
double calculatePitchAndRoll(Measurements measurements) {
	double	g_x = measurements.g_x,
			g_y = measurements.g_y,
			g_z = measurements.g_z,
			beta3 = (atan(g_y / sqrt(pow(g_x, 2) + pow(g_z, 2))) * 180.00) / M_PI;


	//moja propozycja pozyskania wynikow
	if (g_z >= 0) {
		return  180.00 - beta3;
	}
	else if (g_z < 0 && beta3 >= 0) {
		return    beta3; 
	}
	else if (g_z < 0 && beta3 <= 0) {
		return 360.00 + beta3; 
	}
	return NAN;
}

double calculatePitchAndRollInstrukcja(Measurements measurements) {
	double	g_x = measurements.g_x,
		g_y = measurements.g_y,
		g_z = measurements.g_z,
		beta3 = (atan(g_y / sqrt(pow(g_x, 2) + pow(g_z, 2))) * 180.00) / M_PI;

	//W mojej opinii podany w instrukcji laboratoryjnej kod na obliczanie wartoœci ROLL
	//jest b³êdy, poni¿sza kombinacja zwraca prawid³owe liczby, dla porównania doda³em równiez funkcjê zaproponowan¹ w instrukcji.

	if (g_z > 0) {
		return beta3;
	}
	else if (g_z < 0 && beta3 > 0) {
		return   180.0 - beta3;
	}
	else if (g_z < 0 && beta3 < 0) {
		return -180.0 - beta3;
	}
	return NAN;
}

int main() {
	double g_x, g_y, g_z;

	Measurements measurements[12];
	measurements[0]  = Measurements(0.00,  0.00,  -1.00);	//0
	measurements[1]  = Measurements(0.00,  0.50,  -0.85);	//30
	measurements[2]  = Measurements(0.00,  0.85,  -0.50);	//60
	measurements[3]  = Measurements(0.00,  1.00,   0.00);	//90 
	measurements[4]  = Measurements(0.00,  0.85,   0.50);	//120  
	measurements[5]  = Measurements(0.00,  0.50,   0.85);	//150 
	measurements[6]  = Measurements(0.00,  0.00,   1.00);	//180
	measurements[7]  = Measurements(1.00, -0.50,   0.85);	//210		
	measurements[8]  = Measurements(0.00, -0.85,   0.50);	//240
	measurements[9]  = Measurements(0.00, -1.00,   0.00);	//270
	measurements[10] = Measurements(0.00, -0.85,  -0.50);	//300	
	measurements[11] = Measurements(0.00, -0.50,  -0.85);	//330	 

	double result, wrong;
	for (int i = 0; i < 12; i++) {
		result = calculatePitchAndRoll(measurements[i]);
		wrong = calculatePitchAndRollInstrukcja(measurements[i]);
		cout.precision(4);
		cout << "oczekiwany: " <<fixed<< (i * 30.0) << "\t" << "moj wzor: " <<fixed<< result <<"\t instrukcja: "<<fixed<<wrong<< endl << endl;
	}

	return 0;
}