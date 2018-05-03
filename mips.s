.data
msg1: .asciiz"enter a"
msg2: .asciiz "enter b"
msg3: .ascizz "enter c"
two: .word2
four: .word4
errormsg: .asciiz "complex root"


.text
main:
lwc1 $f11,two
lwc1 $f1,four

 la $a0,msg1		#ask input for "a"
 li $v0,4
 syscall
 li $v0,6		#input is in $f0
 syscall
 mov.s $f2,$f0
 #input for a=$f2
 #input for b=$f3
 #input for c=$f4
 
  mul.s $f5,$f3,$f3	#$f5=b^2
  mul.s $f6,$f1,$f2
  mul.s $f6,$f6,$f4	#$f6=4ac
  sub.s $f7,$f5,$f6	#$f7=b^2-4ac
  sqrt.s $f8,$f7	#$f8=squareroot of d
  mfc1 $t0,$f8		#$f8=$t0
  blez $t0,complex_label
  
  neg.s $f9,$f3		#$f9=-b
  mul.s $f10,$f11,$f2	#$f10=2a
  add.s $f15,$f9,$f8	#$f15=-b+squareroot of d
  sub.s $f16,$f9,$f8 	#$f16=-b-squareroot of d
  div.s $f17,$f15,$f10	#$f17=-b+squareroot of d/2a
  div.s $f18,$f16,$f10	#$f18=-b-squareroot of d/2a
  
  mov.s $f12,$f17
  li $v0,2 
  syscall
  
  mov.s $f12,$f18
  li $v0,2
  syscall
  complex_label:
  la $a0,errormsg
  li $v0,4
  syscall
  
  exit:
  li $v0,10
  syscallMI
