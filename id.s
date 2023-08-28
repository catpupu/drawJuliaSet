    .data
types:  .asciz "%s"
char:   .asciz  ""
buffer:  .word    100
number1:    .word   0
number2:    .word   0
number3:    .word   0
typenum:   .asciz  "%d"
sum:    .word   0
nextline:    .asciz  "\n"
idandsum:    .asciz  "**Print team member ID and ID summation**\n"
idsummation: .asciz  "ID Summation = %d\n"
str1:    .asciz  "**Please Enter Member 1 ID:**\n"
str2:    .asciz  "**Please Enter Member 2 ID:**\n"
str3:    .asciz  "**Please Enter Member 3 ID:**\n"
    .text
    .global ID
    .global typenum
    .global number1
    .global number2
    .global number3
    .global sum
    .global nextline
ID:
    stmfd   sp!,{lr}

    mov r5, r0
    mov r6, r1
    mov r7, r2
    mov r8, r3

    ldr r0,=types
    ldr r1,=str1
    bl  printf
    ldr r0, =typenum   @first scanf()
    ldr r1, =number1
    bl  scanf

    ldr r0, =types
    ldr r1, =str2
    bl  printf
    ldr r0, =typenum   @second scanf()
    ldr r1, =number2
    bl  scanf

    ldr r0,=types
    ldr r1,=str3
    bl  printf
    ldr r0, =typenum   @third  scanf()
    ldr r1, =number3
    bl  scanf

    ldr r0, =number1    @add    number
    ldr r0, [r0]

    ldr r1, =number2
    ldr r1,[r1]
    add r0,r0,r1

    ldr r1, =number3
    ldr r1,[r1]
    add r0,r0,r1    @r0 is the sum

    ldr r1, =sum
    str r0, [r1,#0]  @input sum



loop:
    ldr r0, =types
    ldr r1, =char
    bl  scanf   @input char
    ldr r0, =char
    ldr r0, [r0]    @r0 is char
    mov r1, #112    @r1 is p
    cmp r0, r1
    beq done
    b  loop
done:
    ldr r0, =types
    ldr r1, =idandsum
    bl  printf  @   "Print id and member"

    ldr r0, =typenum
    ldr r1, =number1
    ldr r1, [r1]
    bl  printf
    ldr r0, =types
    ldr r1, =nextline
    bl  printf

    ldr r0, =typenum
    ldr r1, =number2
    ldr r1, [r1]
    bl  printf
    ldr r0, =types
    ldr r1, =nextline
    bl  printf

    ldr r0, =typenum
    ldr r1, =number3
    ldr r1, [r1]
    bl  printf
    ldr r0, =types
    ldr r1, =nextline
    bl  printf

    ldr r0, =idsummation
    ldr r1, =sum
    ldr r1, [r1]
    bl  printf

    ldr r0, =types
    ldr r1, =end
    bl  printf

    ldr r9, =number1
    ldr r9,[r9]
    str r9, [r5]
    ldr r9, =number2
    ldr r9,[r9]
    str r9, [r6]
    ldr r9, =number3
    ldr r9,[r9]
    str r9, [r7]
    ldr r9, =sum
    ldr r9,[r9]
    str r9, [r8]

    mov r0, #0
    ldmfd   sp!,{lr}
    mov pc,lr
