// DarkRoom node
// you can read out the registers via avalon bus in the following way:
// #define IORD(base,reg) (*(((volatile uint32_t*)base)+reg))
// #define IOWR(base,reg,data) (*(((volatile uint32_t*)base)+reg)=data)
// where reg corresponds to the address of the avalon slave

`timescale 1ns/10ps

module neopixel (
	input clock,
	input reset_n,
	// this is for the avalon interface
	input [5:0] address,
	input write,
	input signed [31:0] writedata,
	input read,
	output signed [31:0] readdata,
	output waitrequest,
	output reg one_wire
);

assign readdata = 
	((address == 0))? send_to_neopixels:
	((address == 1))? color[(32*1)-1:(32*0)] :
	((address == 2))? color[(32*2)-1:(32*1)] :
	((address == 3))? color[(32*3)-1:(32*2)] :
	((address == 4))? color[(32*4)-1:(32*3)] :
	((address == 5))? color[(32*5)-1:(32*4)] :
	((address == 6))? color[(32*6)-1:(32*5)] :
	((address == 7))? color[(32*7)-1:(32*6)] :
	32'hDEAD_BEEF;

parameter NUMBER_OF_NEOPIXEL = 7;

reg [(32*NUMBER_OF_NEOPIXEL)-1:0] color;

reg send_to_neopixels;

always @(posedge clock, negedge reset_n) begin: NEOPIXEL_CONTROL_LOGIC
	reg spi_done_prev; 
	if (reset_n == 0) begin
		send_to_neopixels <= 0;
	end else begin
		// if we are writing via avalon bus and waitrequest is deasserted, write the respective register
		if(write && ~waitrequest) begin
			case(address)
				0: send_to_neopixels <= (writedata[31:0]!=0); 
				1: color[(32*1)-1:(32*0)] <= writedata; 
				2: color[(32*2)-1:(32*1)] <= writedata; 
				3: color[(32*3)-1:(32*2)] <= writedata; 
				4: color[(32*4)-1:(32*3)] <= writedata; 
				5: color[(32*5)-1:(32*4)] <= writedata; 
				6: color[(32*6)-1:(32*5)] <= writedata; 
				7: color[(32*7)-1:(32*6)] <= writedata; 
			endcase 
		end
	end 
end

wire [31:0] timer;

Counter counter(
	.clk(clock),
	.reset(~reset_n),
	.counter(timer)
);

parameter SIZE = 4;
parameter SEND_0  = 0, SEND_1 = 1,LATCH = 2, IDLE = 3;
reg unsigned [3:0] state;
wire unsigned [3:0] next_state;
reg [31:0] bit_ctr;
wire color_bit;
reg start;

assign color_bit = color[bit_ctr];

assign waitrequest = 0;

always @(posedge clock, negedge reset_n) begin: neo_pixel_transmitter
	reg done;
	reg [31:0] t0;
	reg [31:0] t1;
	if(reset_n==0) begin
		start <= 1;
		done <= 0;
		state <= 3;
		bit_ctr <= 32*NUMBER_OF_NEOPIXEL;
	end else begin
		case(state)
			IDLE : 	begin
							if(bit_ctr<(32*NUMBER_OF_NEOPIXEL)) begin
								state <= (color_bit?SEND_0:SEND_1);
							end else begin
								state <= LATCH;
								if(send_to_neopixels)
									bit_ctr <= 0;
							end
						end
			SEND_1 : begin 
							if (start == 1) begin
								t0 <= timer;
								start <= 0;
								done <= 0;
							end else begin
								t1 = timer - t0;
								if( done == 0 ) begin 
									if( t1 < 15 ) begin
										one_wire <= 1;
									end else begin
										done <= 1;
										t0 <= timer;
									end
								end else begin
									if( t1 < 45 ) begin
										one_wire <= 0;
									end else begin
										done <= 0;
										start <= 1;
										t0 <= timer;
										state <= IDLE;
										bit_ctr <= bit_ctr+1;
									end
								end
							end
						end
			SEND_0 : begin
							if (start == 1) begin
								t0 <= timer;
								start <= 0;
								done <= 0;
							end else begin
								t1 = timer - t0;
								if( done == 0 ) begin 
									if( t1 < 30 ) begin
										one_wire <= 1;
									end else begin
										done <= 1;
										t0 <= timer;
									end
								end else begin
									if( t1 < 30 ) begin
										one_wire <= 0;
									end else begin
										done <= 0;
										start <= 1;
										t0 <= timer;
										state <= IDLE;
										bit_ctr <= bit_ctr+1;
									end
								end
							end
						end
			LATCH : begin
							t1 = timer - t0;
							if( done == 0 ) begin 
								if( t1 < 4000 ) begin
									one_wire <= 0;
								end else begin
									done <= 0;
									start <= 1;
									state <= IDLE;
								end
							end
						end
		  default : begin
							state <= IDLE;
						end
		endcase
	end
end
endmodule