// Add near top
wire aes_valid = (r.unit == UNIT_AES);

// Add AES instance
aes_round aes_engine(
    .data_high(r.read_data1),
    .data_low(r.read_data2), 
    .key_high(r.read_data3),
    .key_low(64'b0),  // For now
    .result_high(aes_result_high),
    .result_low(aes_result_low)
);

// In result mux, add:
UNIT_AES: begin
    write_data <= aes_result_high;  // First result
    write_data2 <= aes_result_low;  // Second result
end
