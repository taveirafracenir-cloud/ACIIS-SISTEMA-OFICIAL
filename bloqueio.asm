.data
    
   
    senha_oculta: .byte 22, 13, 13, 20, 21

    ; Espaço para armazenar a senha digitada pelo usuário
    senha_digitada: .space 5

    ; Mensagens para o usuário
    msg_senha:      .asciz "Digite a senha: "
    len_msg_senha = . - msg_senha
    msg_bloqueio:   .asciz "\nSistema Bloqueado. Tente novamente em 13 dias.\n"
    len_msg_bloqueio = . - msg_bloqueio
    msg_liberado:   .asciz "\nBem-vindo ao sistema! Acesso liberado.\n"
    len_msg_liberado = . - msg_liberado

.text
.global _start

_start:
    ; Exibe a mensagem "Digite a senha"
    mov     r7, #4                  ; syscall 'write'
    mov     r0, #1                  ; file descriptor stdout
    ldr     r1, =msg_senha          ; endereço da mensagem
    ldr     r2, =len_msg_senha      ; tamanho da mensagem
    svc     #0

    mov     r4, #0                  ; Contador do loop
    mov     r5, #0                  ; Ponteiro para o buffer da senha digitada

verificar_loop:
    ; Lê um caractere do teclado
    mov     r7, #3                  ; syscall 'read'
    mov     r0, #0                  ; file descriptor stdin
    add     r1, r5, r4              ; Endereço para armazenar o caractere
    mov     r2, #1                  ; Ler apenas 1 byte
    svc     #0

    ; Exibe um '*' para ocultar a senha
    mov     r7, #4
    mov     r0, #1
    mov     r1, #'*'                ; ASCII para o caractere '*'
    mov     r2, #1
    svc     #0

    ; Converte o caractere digitado para um número (exemplo: '9' (ASCII 57) vira 9)
    ldrb    r1, [r5, r4]
    sub     r1, r1, #'0'

    ; Soma o offset (13) para obscurecer o valor e compara com a senha oculta
    add     r1, r1, #13
    ldrb    r2, [r1, r4]            ; Carrega o byte correspondente da senha oculta
    cmp     r1, r2
    bne     senha_incorreta         ; Se forem diferentes, salta para o bloqueio

    add     r4, r4, #1              ; Incrementa o contador
    cmp     r4, #5                  ; Já lemos 5 caracteres?
    bne     verificar_loop          ; Se não, continua o loop

    ; Se o loop terminar, a senha está correta
    b       acesso_liberado

senha_incorreta:
    ; Exibe a mensagem de bloqueio
    mov     r7, #4
    mov     r0, #1
    ldr     r1, =msg_bloqueio
    ldr     r2, =len_msg_bloqueio
    svc     #0

    ; Loop infinito para travar o sistema
    loop_bloqueio:
    b       loop_bloqueio

acesso_liberado:
    ; Exibe a mensagem de sucesso
    mov     r7, #4
    mov     r0, #1
    ldr     r1, =msg_liberado
    ldr     r2, =len_msg_liberado
    svc     #0

    ; AQUI, você chamaria a rotina para carregar e iniciar o kernel e os scripts.
    ; Por exemplo, saltando para uma nova rotina.
    ; b inicializar_kernel

    ; Finaliza o programa por enquanto (para este exemplo)
    mov     r7, #1
    svc     #0
