.data
matrix_size:    .word   5
matrix:         .word   1, 2, 3, 4, 5,
                .word   6, -1, -2, -3, 7,
                .word   8, -4, -5, -6, 9,
                .word   9, -7, -8, -9, 8,
                .word   7, 6, 5, 4, 3,

positive_count: .word 0
negative_count: .word 0

.text
.globl main
main:
    # Загрузка адреса матрицы
    la  t0, matrix
    # Загрузка размерности матрицы
    lw  t1, matrix_size
    # Инициализация индекса строки i
    li  t2, 0
    # Инициализация индекса столбца j
    li  t3, 0
    # Инициализация счетчиков
    li  t4, 0  # Положительные значения
    li  t5, 0  # Отрицательные значения

outer_loop:
    # Проверка условия завершения внешнего цикла
    bge t2, t1, end_outer_loop
    # Инициализация индекса столбца j
    li  t3, 0

inner_loop:
    # Проверка условия завершения внутреннего цикла
    bge t3, t1, end_inner_loop
    # Вычисление индекса элемента матрицы
    mul t6, t2, t1  # t6 = i * N
    add t6, t6, t3  # t6 = i * N + j
    # Загрузка элемента матрицы в регистр t6
    lw  t6, 0(t0)
    # Проверка элемента на положительность
    bgtz    t6, positive
    # Увеличение счетчика отрицательных значений
    addi    t5, t5, 1
    j   continue

positive:
    # Увеличение счетчика положительных значений
    addi    t4, t4, 1

continue:
    # Увеличение адреса элемента матрицы
    addi    t0, t0, 4   # Размер int в байтах
    # Увеличение индекса столбца j
    addi    t3, t3, 1
    j   inner_loop

end_inner_loop:
    # Увеличение индекса строки i
    addi    t2, t2, 1
    j   outer_loop

end_outer_loop:
    # Сохранение результатов в памяти
    la  t1, positive_count
    sw  t4, 0(t1)
    la  t1, negative_count
    sw  t5, 0(t1)


# Вывод результата
    li  a0, 1  # Код для системного вызова print_int
    la  a1, positive_count
    lw  a1, 0(a1)
    ecall

    li  a0, 11  # Код для системного вызова print_int
    li  a1, 32  # ASCII код пробела
    ecall

    li  a0, 1  # Код для системного вызова print_int
    la  a1, negative_count
    lw  a1, 0(a1)
    ecall



