.globl _trampoline
.extern _main

/* setup multiboot header */
/* trampoline routine, setup stack */
/* jump to C++ main */

.set ALIGN,    1 << 0          
.set MEMINFO,  1 << 1        
.set FLAGS,    ALIGN | MEMINFO 
.set MAGIC,    0x1BADB002    
.set CHECKSUM, -(MAGIC + FLAGS) 

.section .multiboot
.align 4

.long MAGIC
.long FLAGS
.long CHECKSUM

.section .bss
.align 16
_stack_start:
    .skip 16384
_stack_end:

.section .text

_trampoline:
    mov esp, _stack_end
    jmp _main
_done:
    cli
    hlt
    jmp _done