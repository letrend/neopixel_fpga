module OC_Can_av_wrapper(

     //Avalon common
    input                   av_clk,
    input                   av_reset,
    //Avalon control port
    input  [7:0]            av_address,
    input                   av_chipselect,
    input                   av_write,
    input                   av_read,
    input  [31:0]           av_writedata,
    output [31:0]           av_readdata,
    input  [3:0]            av_byteenable,
    output                  av_waitrequest_n,

	// CAN interface
	input		CAN_clk,
	input		CAN_reset,
	input		CAN_rx,
	output		CAN_tx,
	output       	CAN_bus_off,
	output       	CAN_irq,
	output       	CAN_clkout

);


wire wb_ack_o;

assign av_waitrequest_n = wb_ack_o;
assign av_readdata[31:8] = 24'hz;

`define CAN_WISHBONE_IF

can_top wishbone_can_inst
( 
  .wb_clk_i(av_clk),
  .wb_rst_i(av_reset | CAN_reset),
  .wb_dat_i(av_writedata[7:0]),
  .wb_dat_o(av_readdata[7:0]),
  .wb_cyc_i(av_write | av_read),
  .wb_stb_i(av_chipselect & (av_write | av_read)),
  .wb_we_i(av_write & ~av_read),
  .wb_adr_i({av_address[7:0]}),
  .wb_ack_o(wb_ack_o),

  .clk_i(CAN_clk),
  .rx_i(CAN_rx),
  .tx_o(CAN_tx),
  .bus_off_on(CAN_bus_off),
  .irq_on(CAN_irq),
  .clkout_o(CAN_clkout)

);
endmodule
