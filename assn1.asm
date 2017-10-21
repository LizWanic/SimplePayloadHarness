; Elizabeth Wanic
; 10 April 2017
; CS4678 - Assignment 1
; Command line for assembly : 
;    nasm -f bin assn1.asm
;  
; 

bits 32                 ; 32 bit program

;start:
	jmp 	short bottom 		; jump to bottom 

top:
; open the file
	pop 	esi 				; address of secret
    mov     ebx, esi	        ; name of file 
    mov     ecx, 0              ; 
    mov     edx, 0              ; 
    mov 	eax, 0x05 			; 5 sys call for open
    int     0x80                ; execute sys call
    
    push 	eax 			    ; fd onto stack  
    push    eax                 ; make room for read/write byte

read:
    mov     ebx, [esp+4]        ; fd for file
    mov     eax, 0x03           ; 3 sys call for read
    mov     ecx, esp            ; put the byte here
    mov     edx, 0x01           ; read one byte 
    int     0x80

    cmp     eax, 0x00           ; check if read anything
    jle     exit                ; jump out if finished or error

; write the file to stdout
	mov     eax, 0x04           ; 4 sys call for write
    mov     ebx, 0x01           ; fd for stdout is 1
    mov     edx, 0x01           ; write 1 byte
    mov     ecx, esp            ; take the byte off the stack 
    int     0x80                ; execute write sys call
    jmp     read 

exit:
; exit system call 	
	xor 	eax, eax 			; eax is 0 
    mov     ebx, 0  
	inc 	eax 				; 1 is sys call for exit
	int 	0x80 				; execute sys call 
    
bottom:
  	call top 
    db "secret",0