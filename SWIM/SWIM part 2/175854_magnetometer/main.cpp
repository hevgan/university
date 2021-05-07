#define _CRT_SECURE_NO_WARNINGS
#define _USE_MATH_DEFINES
#include<stdio.h>
#include <cmath>
#include <iostream>
double calculateAlpha(double H_x, double H_y) {

		double to_radians = 180.0 / M_PI;
	
		if (H_x > 0 && H_y >= 0)
		{
			return  atan(H_y / H_x) * to_radians;
		}
		else if (H_x > 0 && H_y < 0)
		{
			return   360.0 + atan(H_y / H_x) * to_radians;
		}
		else if (H_x < 0)
		{
			return   180.0 + atan(H_y / H_x) * to_radians;
		}
		else if (H_x == 0 && H_y > 0)
		{
			return   90.0;
		}
		else if (H_x == 0 && H_y < 0)
		{
			return   270.0;
		}
		printf("Podano zle dane!");
		return 420;
	
}


int main() {

	double H_x, H_y ;
	double alfa;
	while (true) {
		std::cout << "podaj H_x: ";
		std::cin >> H_x;
		std::cout << "podaj H_y: ";
		std::cin >> H_y;

		alfa = calculateAlpha(H_x, H_y);
		std::cout <<"azymut: "<< alfa << std::endl<<std::endl;

	}


	
	return 0;
}