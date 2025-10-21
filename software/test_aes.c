#include <stdio.h>
#include "aes_hw.h"

void test_aes_instruction(void) {
    unsigned long data_high = 0x0123456789ABCDEF;
    unsigned long data_low = 0xFEDCBA9876543210;
    unsigned long key_high = 0x0011223344556677;
    unsigned long result_high, result_low;
    
    printf("Testing AES instruction...\n");
    printf("Input:  %016lx %016lx\n", data_high, data_low);
    printf("Key:    %016lx\n", key_high);
    
    // Call our custom instruction
    AES_ENCRYPT_ROUND(result_high, result_low, data_high, data_low, key_high);
    
    printf("Output: %016lx %016lx\n", result_high, result_low);
    printf("Expected XOR: %016lx %016lx\n", 
           data_high ^ key_high, data_low ^ key_high);
}

int main() {
    test_aes_instruction();
    return 0;
}
