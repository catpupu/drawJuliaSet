    .data

    .text
    .global drawJuliaSet

    @   r0  temp
    @   r4  cY
    @   r5  frame
    @   r6  x
    @   r7  y
    @   r8  color,i
    @   r9  zx
    @   r10 zy

drawJuliaSet:

    stmfd sp!,{r4-r11,lr}
    adds    r14, r0, r15
    mov r4,r0   @ cY = first parameter
    mov r5,r1   @ frame = second parameter
    mov r6,#0   @ initialize x = 0 (for w_loop)
@-----------------------------
    @ height_loop have 3 part
    @ 1.above while(h_loop1)
    @ 2.while
    @ 3.and down while(h_loop2)
@-----------------------------
w_loop:

    @ w_loop condition
    cmp r6,#640 @ for (x<640)
    bge end
    mov r7,#0   @ initialize y = 0 (for h_loop)
@-----------------------------
h_loop1:

    @ h_loop1 condition
    cmp r7,#480     @ for (y<480)
    bge xplus       @ x++

    @math

    @ zx = ( 1500y-480000 )/320
    ldrne   r0, .number      @ r0 = 1500
    mullt   r0, r0, r6       @ r0 = 1500x
    ldrls   r1, .number+4    @ r1 = -480000
    sub   r0, r0, r1       @ r0 = (1500x - 480000)
    mov   r1, #320         @ r1 = 320
    bl    __aeabi_idiv     @ r0 = ( ... ) / 320
    mov   r9, r0           @ zx = answer

    @ zy = ( 1000y-240000 )/240
    mov   r0, #1000        @ r0 = 1000
    mul   r0, r0, r7       @ r0 = 1000y
    ldr   r1, .number+8    @ r1 = -240000
    sub   r0, r0, r1       @ r0 = 1000y - 240000
    mov   r1, #240         @ r1 = 240
    bl    __aeabi_idiv     @ r0 = ( ... ) / 240
    mov   r10, r0          @ zy = answer

    mov r8, #255           @ initialize i = 255(for while)
@-----------------------------
while:

    @ while condition
    mul   r0, r9, r9       @ r0 = zx * zx
    mul   r1, r10, r10     @ r1 = zy * zy
    add   r2, r0, r1       @ r2 = zx * zx + zy * zy
    ldr   r3, .number+20 @ r3 = 400,0000
    cmp   r2, r3           @ zx * zx + zy * zy < 4000000
    bge   h_loop2
    cmp   r8, #0           @ i > 0
    ble   h_loop2

    @math
    sub r0, r0, r1         @ r0 = zx * zx - zy * zy
    mov r1, #1000
    bl  __aeabi_idiv       @ r0 = r0 / r1
    sub r0, r0, #700       @ r0 = temp = (zx * zx - zy * zy)/1000 - 700
    mov r11, r0            @ r11= temp = (zx * zx - zy * zy)/1000 - 700

    mul r0, r9, r10        @ r0 = zx * zy
    mov r0, r0, lsl #1     @ r0 = r0 * 2
    mov r1, #1000
    bl  __aeabi_idiv
    add r10, r0, r4        @ r10 = (2 * zx * zy)/1000 + cY;
    mov r9, r11
    sub r8, r8, #1
    b    while
@-----------------------------
h_loop2:
    @ set color,frame
    ldr r0, .number+12
    and r8, r8, r0
    orr r8, r8, r8, lsl #8   @ r8 = r8|(r8<<8)
    ldr r0, .number+16
    bic r8, r0, r8           @ color = 0xffff & (~color)

    mov   r0, r5             @ r0 = frame
    mov   r1, #1280          @ int= 2byte
    mul   r1, r1, r7         @ r1 = 1280y
    add   r0, r1             @ r0 = frame + 1280y
    add   r0, r6, lsl #1     @ r0 = frame[y][x] = frame+1280y+2x
    strh  r8, [r0]           @ frame[y][x] = color
    b     yplus              @ y++
@-----------------------------
end:
    ldmfd   sp!,{r4-r11,lr}
    mov pc,lr
@-----------------------------
xplus:
    add r6,r6,#1    @ x++
    b   w_loop
@-----------------------------
yplus:
    add r7,r7,#1    @ y++
    b   h_loop1
@-----------------------------
.number:
    .word   1500
    .word   480000
    .word   240000
    .word   0xff
    .word   0xffff
    .word   4000000

