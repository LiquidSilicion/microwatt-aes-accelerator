// Add to instruction decoding section
wire is_aes_op = (insn[31:26] == `OPCODE_AES);
wire aes_encrypt = is_aes_op & (insn[10:1] == `AES_ENCRYPT);

// In the decode logic, add:
if (is_aes_op) begin
    decode_ctl.unit <= UNIT_AES;
    decode_ctl.valid <= 1'b1;
end
