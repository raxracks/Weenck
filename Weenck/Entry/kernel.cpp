#include "../Redshift/libs/terminal.cpp"
#include "../Redshift/libs/cstr.cpp"

extern "C" void kernel_main()
{ 
	Clear();
	PrintString("Output: ");
	PrintString(itoa(14));
	PrintString(itoa(-17));
	PrintString(itoa(255, 2));

	while(1); //halt
}