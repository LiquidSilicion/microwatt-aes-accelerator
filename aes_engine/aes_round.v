//WHAT: The actual encryption logic
//ANALOGY: A specialized cooking recipe

//FUNCTION:
//• Input: 128-bit data + 128-bit key
//• Performs: AES encryption steps (SubBytes, ShiftRows, etc.)
//• Output: 128-bit encrypted data
//• Type: Combinatorial = output ready immediately (no clock delay)

//PURPOSE: Does the actual cryptographic work


module aes_round(
  input wire [127:0]state_in;
  input wire [127:0]round_key;
  input wire final_state;
  output wire [127:0]state_out;
  );
  wire [127:0] subbytes_out;
  wire [127:0] shiftrows_out; 
  wire [127:0] mixcolumns_out;
  wire [127:0] addroundkey_out;
  
