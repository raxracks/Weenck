#include "terminal.cpp"
#include "cstr.cpp"

extern "C" void kernel_main()
{ 
	Clear();
	PrintString("Output: ");
	PrintString(itoa(458));
	PrintString(itoa(-459));

	while(1); //halt
}