  .global main
  .type main,%function
main:
  push {r7, lr}
  sub sp, #12 // int choice, operand1, operand2;
__loop:
  movw r0, :lower16:(STRING_2-(LPC1_0+4))
  movt r0, :upper16:(STRING_2-(LPC1_0+4))
  add r0, pc
LPC1_0:
  blx printf
  mov r1, sp
  movw r0, :lower16:(STRING_1-(LPC1_1+4))
  movt r0, :upper16:(STRING_1-(LPC1_1+4))
  add r0, pc
LPC1_1:
  blx scanf
  ldr r2, [sp]
  // transition table
  mov r0, #0
  // if (r2 == #0) goto __return;
  cmp r2, #0
  beq __return
  // else
  str r2, [sp]
  mov r0, sp
  add r0, #4
  bl get_operands
  ldr r2, [sp]
  ldr r0, [sp, #4]
  ldr r1, [sp, #8]
  // if (r2 == #1) goto _add_op;
  cmp r2, #1
  beq _add_op
  // else if (r2 == #2) goto _sub_op;
  cmp r2, #2
  beq _sub_op
  // else if (r2 == #3) goto _mul_op;
  cmp r2, #3
  beq _mul_op
  // else if (r2 == #4) goto _div_op;
  cmp r2, #4
  beq _div_op
  // else
  mov r0, r2
  bl print_error
  mov r0, #1
  b __return
_add_op:
  add r0, r1
  b _table_end
_sub_op:
  sub r0, r1
  b _table_end
_mul_op:
  mul r0, r1
  b _table_end
_div_op:
  bl __aeabi_idiv
_table_end:
  mov r1, r0
  movw r0, :lower16:(STRING_3-(LPC1_2+4))
  movt r0, :upper16:(STRING_3-(LPC1_2+4))
  add r0, pc
LPC1_2:
  blx printf
  b __loop
__return:
  add sp, #12
  pop {r7, pc} // return 0;

get_operands:
  push {r0, r7, lr}

  mov r1, #1
  movw r0, :lower16:(STRING_4-(LPC2_0+4))
  movt r0, :upper16:(STRING_4-(LPC2_0+4))
  add r0, pc
LPC2_0:
  blx printf

  ldr r1, [sp]
  movw r0, :lower16:(STRING_1-(LPC2_1+4))
  movt r0, :upper16:(STRING_1-(LPC2_1+4))
  add r0, pc
LPC2_1:
  blx scanf

  mov r1, #2
  movw r0, :lower16:(STRING_4-(LPC2_2+4))
  movt r0, :upper16:(STRING_4-(LPC2_2+4))
  add r0, pc
LPC2_2:
  blx printf

  ldr r1, [sp]
  add r1, #4
  movw r0, :lower16:(STRING_1-(LPC2_3+4))
  movt r0, :upper16:(STRING_1-(LPC2_3+4))
  add r0, pc
LPC2_3:
  blx scanf
  add sp, #4
  pop {r7, pc}

print_error:
  push {r7, lr}
  mov r1, r0
  movw r0, :lower16:(STRING_5-(LPC3_0+4))
  movt r0, :upper16:(STRING_5-(LPC3_0+4))
  add r0, pc
LPC3_0:
  blx printf
  pop {r7, pc}

  .type STRING_1,%object
  .section .rodata.strings,"aMS",%progbits,1
  .type STRING_2,%object
  .section .rodata.strings,"aMS",%progbits,1
  .type STRING_3,%object
  .section .rodata.strings,"aMS",%progbits,1
  .type STRING_4,%object
  .section .rodata.strings,"aMS",%progbits,1
  .type STRING_4,%object
  .section .rodata.strings,"aMS",%progbits,1
STRING_1:
  .asciz "%d"
STRING_2:
  .asciz "Select operation:
  0.   (exit)
  1. + (add)
  2. - (subtract)
  3. * (multiply)
  4. / (divide)
  > "
STRING_3:
  .asciz "Result: %d\n"
STRING_4:
  .asciz "Enter operand no.%d: "
STRING_5:
  .asciz "Option %d is invalid.\n"
