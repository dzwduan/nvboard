// module top (
//     input clk,
//     input rst,
//     input [7:0] sw,
//     input ps2_clk,
//     input ps2_data,
//     output [15:0] ledr,
//     output VGA_CLK,
//     output VGA_HSYNC,
//     output VGA_VSYNC,
//     output VGA_BLANK_N,
//     output [7:0] VGA_R,
//     output [7:0] VGA_G,
//     output [7:0] VGA_B,
//     output [7:0] seg0,
//     output [7:0] seg1,
//     output [7:0] seg2,
//     output [7:0] seg3,
//     output [7:0] seg4,
//     output [7:0] seg5,
//     output [7:0] seg6,
//     output [7:0] seg7
// );

// led led1(
//     .clk(clk),
//     .rst(rst),
//     .sw(sw),
//     .ledr(ledr)
// );

// assign VGA_CLK = clk;

// wire [9:0] h_addr;
// wire [9:0] v_addr;
// wire [23:0] vga_data;

// vga_ctrl my_vga_ctrl(
//     .pclk(clk),
//     .reset(rst),
//     .vga_data(vga_data),
//     .h_addr(h_addr),
//     .v_addr(v_addr),
//     .hsync(VGA_HSYNC),
//     .vsync(VGA_VSYNC),
//     .valid(VGA_BLANK_N),
//     .vga_r(VGA_R),
//     .vga_g(VGA_G),
//     .vga_b(VGA_B)
// );

// ps2_keyboard my_keyboard(
//     .clk(clk),
//     .resetn(~rst),
//     .ps2_clk(ps2_clk),
//     .ps2_data(ps2_data)
// );

// seg mu_seg(
//     .clk(clk),
//     .rst(rst),
//     .o_seg0(seg0),
//     .o_seg1(seg1),
//     .o_seg2(seg2),
//     .o_seg3(seg3),
//     .o_seg4(seg4),
//     .o_seg5(seg5),
//     .o_seg6(seg6),
//     .o_seg7(seg7)
// );

// vmem my_vmem(
//     .h_addr(h_addr),
//     .v_addr(v_addr[8:0]),
//     .vga_data(vga_data)
// );

// endmodule

// module vmem (
//     input [9:0] h_addr,
//     input [8:0] v_addr,
//     output [23:0] vga_data
// );

// reg [23:0] vga_mem [524287:0];

// initial begin
//     $readmemh("resource/picture.hex", vga_mem);
// end

// assign vga_data = vga_mem[{h_addr, v_addr}];

// endmodule



// module top(
//     input [1:0] x0,
//     input [1:0] x1,
//     input [1:0] x2,
//     input [1:0] x3,
//     input [1:0] y,
//     output[1:0] f
// );

//     MuxKeyWithDefault #(4,2,2) mux_demo (
//         f,y,2'b00, {
//             2'b00, x0,
//             2'b01, x1,
//             2'b10, x2,
//             2'b11, x3
//         }
//     );
// endmodule

// module top(x,en,y);
//   input  [1:0] x;
//   input  en;
//   output reg [3:0]y;

//   always @(x or en)
//     if (en)
//     begin
//       case (x)
//             2'd0 : y = 4'b0001;
//             2'd1 : y = 4'b0010;
//             2'd2 : y = 4'b0100;
//             2'd3 : y = 4'b1000;
//       endcase
//     end
//     else  y = 4'b0000;

// endmodule

// module bcd7seg(
//   input  [3:0] b,
//   output reg [6:0] h
// );
// // detailed implementation ...

// endmodule


module top(
    input [7:0] in,
    input en,
    output signal,
    output reg [2:0] out,
    output reg [6:0] seg
);

    always@(in or en) begin
        if (en)
            begin
                casez (in)
                    8'b1???????: out=3'b111;
		            8'b01??????: out=3'b110;
		            8'b001?????: out=3'b101;
		            8'b0001????: out=3'b100;
		            8'b00001???: out=3'b011;
		            8'b000001??: out=3'b010;
		            8'b0000001?: out=3'b001;
		            8'b00000001: out=3'b000;
		            default:     out=3'b000;
                endcase
            end
        else out=3'b000;

        if (en)
            begin
                case (out)
		            3'b111: seg=7'b1111000;
		            3'b110: seg=7'b0000010;
		            3'b101: seg=7'b0010010;
		            3'b100: seg=7'b0011001;
		            3'b011: seg=7'b0110000;
		            3'b010: seg=7'b0100100;
		            3'b001: seg=7'b1111001;
		            3'b000: seg=7'b0111111;

                    // 3'b111: seg=7'b1000000;
		            // 3'b110: seg=7'b0100000;
		            // 3'b101: seg=7'b0010000;
		            // 3'b100: seg=7'b0001000;
		            // 3'b011: seg=7'b0000100;
		            // 3'b010: seg=7'b0000010;
		            // 3'b001: seg=7'b0000001;
		            // 3'b000: seg=7'b0000000;
		            default:seg=7'b0000000;
	            endcase
            end
        else seg=7'b0;
    end

    assign signal = en;


endmodule