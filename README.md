# Weenck
Your day-to-day C++ OS development tool.


# Blueshift - The Bootloader
Blueshift wants to go closer to the hardware and create a safe environment for the Kernel. It should ease the booting into Redshift.
It should also contain 

# Redshift - The Kernel
Redshift goes further away from hardware by abstracting everything. It should contain basic drivers for common devices (VGA, PS/2 Keyboard, PS/2 Mouse) and functions to allow the implementation of other, better drivers.

Kernel should be implemented as a higher half microkernel or macrokernel with modules.

# Entry = The Entry Point
This is where the user writes code. It should mostly behave like a shell with Ring 0 Access. User mode will be implemented on it.
