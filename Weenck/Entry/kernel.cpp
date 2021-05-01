#include "../Redshift/libs/terminal.cpp"
#include "../Redshift/libs/cstr.cpp"

extern "C" void kernel_main()
{ 
	Clear();
	PrintString((char*)"Output: "); //cast to char* so gcc stops crying
	PrintString(itoa(14));
	PrintString(itoa(-17));
	PrintString(itoa(255, 2));

	while(1); //halt
}