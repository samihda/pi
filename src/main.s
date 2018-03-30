.global _start

.section .data
.align 4
PropertyInfo:
  .int PropertyInfoEnd - PropertyInfo
  .int 0

  .int 0x00038041
  .int 8
  .int 0

  .int 130
  .int 1
  .int 0
PropertyInfoEnd:

.section .text
_start:
  mailbox .req r0
  ldr mailbox, =0x3f00b880

  wait1$:
    status .req r1
    ldr status, [mailbox, #0x18]
    tst status, #0x80000000
    .unreq status
    bne wait1$

  message .req r1
  ldr message, =PropertyInfo
  add message, #8
  str message, [mailbox, #0x20]
  .unreq message

  hang:
    b hang
