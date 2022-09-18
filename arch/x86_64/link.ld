ENTRY(_start)

SECTIONS {
	. = 1M;
	
	.multiboot : {
		KEEP(*(.multiboot))
		*(.multiboot)
	}
	
	.text : {
		*(.text)
	}

	.rodata : {
		*(.rodata)
	}

	.data : {
		*(.data)
	}

	.bss : {
		*(.bss)
	}
}
