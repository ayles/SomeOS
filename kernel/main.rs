#![no_std]

extern crate rlibc;
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

#[no_mangle]
pub extern fn kernel_main() -> ! {
    let vga = unsafe { core::slice::from_raw_parts_mut(0xb8000 as *mut u16, 4000) };

    for n in 0..4000 {
        vga[n] = 0x4000
    }

    vga[0] = 0x2f4b;
    vga[1] = 0x2f65;
    vga[2] = 0x2f4b;

    loop { }
}
