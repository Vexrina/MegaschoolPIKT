#include <stdio.h>

void count_positive_negative(int array[5][5], int *positive_count, int *negative_count) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
            if (array[i][j] > 0) {
                (*positive_count)++;
            } else if (array[i][j] < 0) {
                (*negative_count)++;
            }
        }
    }
}

int main() {
    int array[5][5] = {
        {1, 2, 3, 4, 5},
        {6, -1, -2, -3, 7},
        {8, -4, -5, -6, 9},
        {9, -7, -8, -9, 8},
        {7, 6, 5, 4, 3}
    };
    int positive_count = 0;
    int negative_count = 0;
    count_positive_negative(array, &positive_count, &negative_count);
    printf("%d %d\n", positive_count, negative_count);
    return 0;
}
