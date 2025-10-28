module sub_bytes_module(
    input [127:0] state_in,
    output [127:0] state_out
);
  genvar i;
    for (i = 0; i < 16; i = i + 1) begin
        s_box sbox_inst (
            .byte_in(state_in[i*8 +: 8]),
            .byte_out(state_out[i*8 +: 8])
        );
    end
endmodule
