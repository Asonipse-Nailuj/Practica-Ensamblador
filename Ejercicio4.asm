;Flujo y estructura básica de ensamblador
.model small
.stack
.data
    msg1 db 'Ingrese el primer numero: $'
    msg2 db 0Dh, 0Ah, 'Ingrese el segundo numero: $'
    msg3 db 0Dh, 0Ah, 'El producto es: $'
    num1 db 0
    num2 db 0
    result db 6 dup (?) ; Buffer para el resultado (incluye espacio para el terminador '$')
.code
    main proc
        ; Configurar segmento de datos
        mov ax, @data
        mov ds, ax

        ; Solicitar primer numero
        lea dx, msg1
        mov ah, 09h
        int 21h

        ; Leer primer numero
        mov ah, 01h
        int 21h
        sub al, 30h  ; Convertir de ASCII a número
        mov num1, al

        ; Solicitar segundo numero
        lea dx, msg2
        mov ah, 09h
        int 21h

        ; Leer segundo numero
        mov ah, 01h
        int 21h
        sub al, 30h  ; Convertir de ASCII a número
        mov num2, al

        ; Multiplicar los números
        mov al, num1  ; Cargar el primer número en AL
        mov bl, num2  ; Cargar el segundo número en BL
        mul bl        ; Multiplicar AL por BL (resultado en AX)

        ; Convertir el resultado a una cadena ASCII
        mov cx, 10         ; Divisor para obtener dígitos decimales
        mov di, offset result + 5 ; Apuntar al final del buffer de resultado
        mov byte ptr [di], '$' ; Terminar la cadena con '$'
        dec di            ; Mover a la posición antes del terminador

        ; Convertir el resultado (en AX) a cadena de caracteres
        convert_loop:
            xor dx, dx        ; Limpiar DX antes de la división
            div cx            ; Dividir AX por 10 (DX:AX / 10)
            add dl, 30h       ; Convertir el dígito a ASCII
            mov [di], dl      ; Almacenar el dígito en el buffer
            dec di            ; Mover a la posición anterior
            test ax, ax       ; Verificar si AX es 0
            jnz convert_loop  ; Repetir si AX no es 0

        ; Mostrar mensaje resultado
        lea dx, msg3
        mov ah, 09h
        int 21h

        ; Mostrar valor del resultado
        mov dx, di        ; Apuntar al inicio del buffer de resultado
        mov ah, 09h
        int 21h

        .exit
        main endp
    end main