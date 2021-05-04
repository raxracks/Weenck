#pragma once
#include "IO.cpp"
#include "typedefs.h"
#include "cstr.cpp"

#include <stdarg.h>

unsigned short* VGA_MEMORY =(unsigned short*)0xb8000;

enum vga_color {
	VGA_COLOR_BLACK = 0,
	VGA_COLOR_BLUE = 1,
	VGA_COLOR_GREEN = 2,
	VGA_COLOR_CYAN = 3,
	VGA_COLOR_RED = 4,
	VGA_COLOR_MAGENTA = 5,
	VGA_COLOR_BROWN = 6,
	VGA_COLOR_LIGHT_GREY = 7,
	VGA_COLOR_DARK_GREY = 8,
	VGA_COLOR_LIGHT_BLUE = 9,
	VGA_COLOR_LIGHT_GREEN = 10,
	VGA_COLOR_LIGHT_CYAN = 11,
	VGA_COLOR_LIGHT_RED = 12,
	VGA_COLOR_LIGHT_MAGENTA = 13,
	VGA_COLOR_LIGHT_BROWN = 14,
	VGA_COLOR_WHITE = 15,
};

vga_color foreground = VGA_COLOR_WHITE;
vga_color background = VGA_COLOR_BLACK;
uint_16 cursor_x = 0;
uint_16 cursor_y = 0;    
const int VGA_WIDTH = 80;
const int VGA_HEIGHT = 25;


unsigned short cursorPosition;

void setCursorPosition(uint_16 x, uint_16 y)
{

	uint_16 position = x + y * VGA_WIDTH;

	outb(0x3D4, 0x0F);
	outb(0x3D5, (unsigned char)(position & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (unsigned char)((position >> 8) & 0xFF));

	cursor_x = x;
	cursor_y = y; 
}

void updateCursorPosition()
{
	uint_16 position = cursor_x + cursor_y * VGA_WIDTH;

	outb(0x3D4, 0x0F);
	outb(0x3D5, (unsigned char)(position & 0xFF));
	outb(0x3D4, 0x0E);
	outb(0x3D5, (unsigned char)((position >> 8) & 0xFF));
}

void resetColor()
{
	foreground = VGA_COLOR_WHITE;
	background = VGA_COLOR_BLACK;
}

void putChar_At(char c, int col, int row, vga_color fg, vga_color bg)
{
	VGA_MEMORY[col + row * VGA_WIDTH] = (uint_16) c | (uint_16) (fg | bg << 4) << 8;
}

void putstr(char* str)
{    
	for(int i = 0; str[i]!='\0'; ++i)
	{
		if (str[i] == '\n')
		{
			cursor_x = 0;
			cursor_y++;
			continue;
		}

		putChar_At(str[i], cursor_x, cursor_y, foreground, background);
		cursor_x++;
		if (!(cursor_x < 80))
		{
			cursor_x = 0;
			cursor_y++;
		}
	}	
	updateCursorPosition();
}	

void clear(vga_color bg)
{
	for(int y = 0; y < VGA_HEIGHT; y++)
	{
		for(int x = 0; x < VGA_WIDTH; x++)
		{
			VGA_MEMORY[y * VGA_WIDTH + x] = (uint_16) ' ' | (uint_16) (bg << 4) << 8;
		}
	}	
}
void clear() { clear(background);}

void printf(char *c, ...)
{
    char *s;
    va_list lst;
    va_start(lst, c);
    while(*c != '\0')
    {
        if(*c != '%')
        {
            putChar_At(*c, cursor_x, cursor_y, foreground, background); cursor_x++; 
            c++;
            continue;
        }

		c++;

        if(*c == '\0')
        {
            break;
        }

		switch(*c)
        {
            case 's': putstr(va_arg(lst, char *)); break;
            case 'd': putstr(itoa(va_arg(lst, int))); break;
			case 'i': putstr(itoa(va_arg(lst, int))); break;
			case 'x': putstr(itoa(va_arg(lst, int), 16)); break;
        }
        c++;
    }
	updateCursorPosition();
}

