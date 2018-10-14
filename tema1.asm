%include "io.inc"

section .data
    %include "input.inc"
    wrongbase db "Baza incorecta", 10, 0

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    xor esi, esi
next:
    mov eax, dword[nums_array + esi * 4] ; number to be converted
    mov ebx, dword[base_array + esi * 4] ; base to convert in
    
    ; check base
    cmp ebx, 2
    jl wrong_base
    cmp ebx, 16
    jg wrong_base
    
    ; continuously divide eax by ebx until eax = 0, pushing the remainder (edx) on the stack
    xor ecx, ecx
convert:
    xor edx, edx
    inc ecx
    div ebx
    push edx
    test eax, eax
    jne convert

    ; print converted number from the stack
print1:
    pop eax
    cmp eax, 10
    jl print2
    add eax, 39
print2:
    add eax, 48
    PRINT_CHAR eax
    loop print1
    NEWLINE
    
    jmp done
wrong_base:
    PRINT_STRING wrongbase
    
done:
    inc esi
    mov eax, dword[nums]
    cmp esi, eax
    jl next
    
    xor eax, eax
    ret