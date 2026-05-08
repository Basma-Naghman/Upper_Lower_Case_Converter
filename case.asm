org 100h

section .data
    prompt    db 'Enter text: $'
    result    db 0Dh, 0Ah, 'Output: $'
    ; The Buffer: 50 is max size, 0 is actual count, then 50 empty bytes
    buffer    db 50, 0
    buffer_data times 52 db 0

section .text
start:
    ; 1. Print Prompt
    mov dx, prompt
    mov ah, 09h
    int 21h

    ; 2. Take Input
    mov dx, buffer
    mov ah, 0Ah
    int 21h

    ; 3. Setup the Loop
    xor cx, cx
    mov cl, [buffer+1]   ; Get how many characters were typed
    mov si, buffer
    add si, 2            ; Point to the first letter

convert_loop:
    cmp cl, 0
    je print_it          ; If we checked all letters, stop
    
    mov al, [si]         ; Pick up a letter

    ; Check if it's a letter (A-Z or a-z)
    cmp al, 'A'
    jb next_char
    cmp al, 'z'
    ja next_char

    ; Flip the case!
    xor al, 32
    mov [si], al         ; Put it back in memory

next_char:
    inc si               ; Move to next letter
    dec cl               ; One less to do
    jmp convert_loop

print_it:
    ; 4. Add the '$' at the end of what was typed
    mov bl, [buffer+1]
    xor bh, bh
    mov byte [buffer + 2 + bx], '$'

    ; 5. Print Result
    mov dx, result
    mov ah, 09h
    int 21h

    mov dx, buffer
    add dx, 2            ; Skip the size info bytes
    mov ah, 09h
    int 21h

    ; Exit
    mov ax, 4C00h
    int 21h