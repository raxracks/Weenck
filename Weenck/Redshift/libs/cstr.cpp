#include <cmath>
#include "typedefs.h"
#include "terminal.cpp"

char intTo_StringOutput[128];
char * itoa(int value, int base = 10)
{
    char* str = "";

    char * rc;
    char * ptr;
    char * low;
    // Check for supported base.
    if ( base < 2 || base > 36 )
    {
        *str = '\0';
        return str;
    }
    rc = ptr = str;
    // Set '-' for negative decimals.
    if ( value < 0 && base == 10 )
    {
        *ptr++ = '-';
    }
    // Remember where the numbers start.
    low = ptr;
    // The actual conversion.
    do
    {
        // Modulo is negative for negative value. This trick makes abs() unnecessary.
        *ptr++ = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz"[35 + value % base];
        value /= base;
    } while ( value );
    // Terminating the string.
    *ptr-- = '\0';
    // Invert the numbers.
    while ( low < ptr )
    {
        char tmp = *low;
        *low++ = *ptr;
        *ptr-- = tmp;
    }
    return rc;
}

int atoi(char* str)
{
    // Initialize result
    int res = 0;
 
    // Initialize sign as positive
    int sign = 1;
 
    // Initialize index of first digit
    int i = 0;
 
    // If number is negative,
    // then update sign
    if (str[0] == '-') {
        sign = -1;
 
        // Also update index of first digit
        i++;
    }
 
    // Iterate through all digits
    // and update the result
    for (; str[i] != '\0'; ++i)
        res = res * 10 + str[i] - '0';
 
    // Return result with sign
    return sign * res;
}

bool isAlpha(char* str)
{
    for (int i = 0; str[i] != 0; i++) 
    {
        if (!((str[i] > 64 && str[i] < 91) || (str[i] > 96 && str[i] < 123)))
            return false;
    }
    return true;
}

bool isAlphaNumeric(char* str)
{
    for (int i = 0; str[i] != 0; i++) 
    {
        if (!((str[i] > 64 && str[i] < 91) || (str[i] > 96 && str[i] < 123) || (str[i] > 47 && str[i] < 58)))
            return false;
    }
    return true;
}

bool isNumeric(char* str)
{
    for (int i = 0; str[i] != 0; i++) 
    {
        if (!(str[i] > 47 && str[i] < 58))
            return false;
    }
    return true;
}