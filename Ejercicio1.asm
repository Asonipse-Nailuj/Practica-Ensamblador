; Flujo y estructura básica de ensamblador
.model small
.stack
.data
    msg db 'Julian Andres Espinosa Torres - CC. 1094970366', 0Dh, 0Ah, '$'
.code
    main proc
        ; Configurar segmento de datos
        mov ax, @data
        mov ds, ax

        ; Apuntar al primer mensaje
        lea dx, msg

        ; Llamar a la función para imprimir el mensaje
        mov ah, 09h
        int 21h

        .exit
        main endp
    end main