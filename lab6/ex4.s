.data
nums:  .byte  10, -21, -30, 45
Sf:  .string "%d\n"    # string de formato para printf

.text
.globl  main
main:
  pushq     %rbp
  movq      %rsp, %rbp
  subq      $16, %rsp
  movq      %rbx, -8(%rbp)
  movq      %r12, -16(%rbp)

  movl      $0, %ebx            # i = 0
  movq      $nums, %r12         # p = &nums

L1:
  cmpl      $4, %ebx            # if (ebx == 4) ?
  je        L2                  # goto L2

  movsbl    (%r12), %eax        # eax = *r12

  movq      $Sf, %rdi
  movl      %eax, %esi
  call      printf

  addl      $1, %ebx            # i++
  addq      $1, %r12            # p++
  jmp       L1

L2:
  movq      $0, %rax
  movq      -8(%rbp), %rbx
  movq      -16(%rbp), %r12
  leave
  ret
