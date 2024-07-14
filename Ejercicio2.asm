;Flujo y estructura básica de ensamblador
.model small
.stack 
.data
    msg1 db 'Ingrese el primer numero: $'
    msg2 db 0Dh, 0Ah, 'Ingrese el segundo numero: $'
    msg3 db 0Dh, 0Ah, 'La suma es: $'
    num1 db 0
    num2 db 0
    result db 0, '$'
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

        ; Sumar los números
        mov al, num1
        add al, num2
        add al, 30h  ; Convertir de número a ASCII
        mov result, al
        
        ; Mostrar mensaje resultado
        lea dx, msg3
        mov ah, 09h
        int 21h

        ; Mostrar valor del resultado
        lea dx, result
        mov ah, 09h
        int 21h

        .exit
        main endp
    end main