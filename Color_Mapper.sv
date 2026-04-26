//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input  logic [9:0] DrawX, DrawY,
                       input logic clk_25MHz, 
                       output logic [3:0]  Red, Green, Blue );
                       
                    
logic [13:0] jack_addr, paul_addr;
logic [14:0] bg_addr;
logic [9:0] drawx, drawy;
logic [3:0] jack_r, jack_g, jack_b;
logic [3:0] paul_r, paul_g, paul_b;
logic [3:0] bg_r, bg_g, bg_b;

logic [3:0] jack_r_d, jack_g_d, jack_b_d;
logic [3:0] paul_r_d, paul_g_d, paul_b_d;
logic [3:0] bg_r_d, bg_g_d, bg_b_d;

logic paul_bounds, jack_bounds, paul_bounds_d, jack_bounds_d;
logic paul_t, jack_t, bg_t;

// CITE!!!
//hardcodinggggg :P
    localparam PAULX = 10'd80;
    localparam PAULY = 10'd100;
    localparam JACKX = 10'd380;
    localparam JACKY = 10'd100;
    
   localparam SPRITE_W  = 64;
    localparam SPRITE_H  = 128;
    localparam SCALE     = 2;
    localparam FRAME_PIX = SPRITE_W * SPRITE_H;  // 8192
    localparam BG_W      = 256;
    localparam BG_H      = 128;
    localparam FRAME_W   = 640;
    localparam FRAME_H   = 480;
    localparam PAUL_FRAME = 3'h0;
    localparam JACK_FRAME = 3'h0;
    
always_ff @ (posedge clk_25MHz) begin
    drawx <= DrawX;
    drawy <= DrawY;
   end
   
 //CITE!!!!
 logic signed [10:0] paul_lx, paul_ly;
 logic signed [10:0] jack_lx, jack_ly;
 
assign paul_lx = {1'b0, drawx} - {1'b0, PAULX};
assign paul_ly = {1'b0, drawy} - {1'b0, PAULY};
assign jack_lx = {1'b0, drawx} - {1'b0, JACKX};
assign jack_ly = {1'b0, drawy} - {1'b0, JACKY};

assign paul_bounds = (~paul_lx[10]) && (~paul_ly[10]) && (paul_lx < SPRITE_W * SCALE) && (paul_ly < SPRITE_H * SCALE);
assign jack_bounds = (~jack_lx[10]) && (~jack_ly[10]) && (jack_lx < SPRITE_W * SCALE) && (jack_ly < SPRITE_H * SCALE);

 
// address calcs CITEEE!!!

assign paul_addr = paul_bounds ? (PAUL_FRAME * FRAME_PIX) + ((paul_ly >> 1) * SPRITE_W) + (paul_lx >> 1) : 13'b0;
assign jack_addr = jack_bounds ? (JACK_FRAME * FRAME_PIX) + ((jack_ly >> 1) * SPRITE_W) + (SPRITE_W -1 - (jack_lx >>1)) : 13'b0;
assign bg_addr = ((drawx * 256) / 640) + (((drawy * 128) / 480) * 256);


//assign jack_addr = drawx 

//assign paul_addr =

//assign bg_addr =


jack_m Jack (
    .pix_clk(clk_25MHz),
    .addr(jack_addr),
    .DrawX(drawx),
    .DrawY(drawy),
    .blank(1'b1),
    .red(jack_r),
    .green(jack_g),
    .blue(jack_b)

);

paul_m Paul (
    .pix_clk(clk_25MHz),
    .addr(paul_addr),
    .DrawX(drawx),
    .DrawY(drawy),
    .blank(1'b1),
    .red(paul_r),
    .green(paul_g),
    .blue(paul_b)

);

background_m Kyoto (
    .pix_clk(clk_25MHz),
    .addr(bg_addr),
    .DrawX(drawx),
    .DrawY(drawy),
    .blank(1'b1),
    .red(bg_r),
    .green(bg_g),
    .blue(bg_b)

);

// checking for transparency 
assign paul_t = (paul_r == 4'hF) && (paul_g == 4'h0) && ((paul_b == 4'hC) ||  (paul_b == 4'hB));
assign jack_t = (jack_r == 4'hF) && (jack_g == 4'h0) && ((jack_b == 4'hC) ||  (jack_b == 4'hB));
assign bg_t = (bg_r == 4'hF) && (bg_g == 4'h0) && (bg_b == 4'hF);

//CITEE
always_ff @(posedge clk_25MHz)
begin
    paul_bounds_d <= paul_bounds;
    jack_bounds_d <=jack_bounds;
    
//    paul_r_d <= paul_r;
//    paul_g_d <= paul_g;
//    paul_b_d <= paul_b;
    
//    jack_r_d <= jack_r;
//    jack_g_d <= jack_g;
//    jack_b_d <= jack_b;
    
//    bg_r_d <= bg_r;
//    bg_g_d <= bg_g;
//    bg_b_d <= bg_b;
end



//z orderr
always_comb
begin
    if (jack_bounds_d && !jack_t)
    begin
        Red = jack_r;
        Green = jack_g;
        Blue = jack_b;
    end
    else if (paul_bounds_d && !paul_t)
    begin
        Red = paul_r;
        Green = paul_g;
        Blue = paul_b;
    end
    else if (!bg_t)
    begin
        Red = bg_r;
        Green = bg_g;
        Blue = bg_b;
    end
   else
    begin
        Red = 4'h4;
        Green = 4'h6;
        Blue = 4'h8;
    end
end

 
endmodule
