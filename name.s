        .data
title:  .asciz  "*****Print Name*****\n"
end:    .asciz  "*****End Print*****\n"
team:   .asciz  "Team 9\n"
name1:  .asciz  "Lucas\n"
name2:  .asciz  "Kevin\n"
name3:  .asciz  "Larry\n"

        .text
        .globl  name
        .globl  team
        .globl  name1
        .globl  name2
        .globl  name3

name:
        stmfd   sp!,{lr}    @Line 1
        ldr     r0, =title  @Line 2
        bl      printf      @Line 3
        mov     r0,#0       @Line 4

        mov     r0,sp       @Line 5
        mov     r1,#0       @LIne 6
                            @let r1 + r2 can't carry

        adcs    r13,r1,r2   @Line 7
                            @r13 = sp

        mov     sp,r0       @reset sp

        ldr     r0,=team
        bl      printf
        mov     r0,#0

        ldr     r0,=name1
        bl      printf
        mov     r0,#0

        ldr     r0, =name2
        bl      printf
        mov     r0,#0

        ldr     r0, =name3
        bl      printf
        mov     r0,#0

        ldr     r0, =end
        bl      printf
        mov     r0,#0

        ldmfd   sp!,{lr}
        mov     pc,lr
