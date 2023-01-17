`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Sourav Das
// 
// Create Date: 16.01.2023 08:40:00
// Design Name: Button press detect
// Module Name: button_press
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Push button press detection by avoiding button debouncing
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module button_press(
    input button,		//Push button input
    input clk,		//Clk input
    output out		//Output while pressing button
    );

    //Registers for filp-flops
    reg q1=0,
        q2b=0;
        
    /*
     * Create slow clock of 2.50mSec=400Hz. 
     * No of cycle=0.5*(100MHz/400Hz)=125,000
     */
    reg [16:0]count=0;	//Counter
    reg clk_slow=0;	//Output of slow clock
    always @(posedge clk) begin
        count <= count+1;
        if(count == 125_000) begin
            count <= 0;
            clk_slow <= ~clk_slow;
        end
    end

    // Two D-ff ckt
    always @(posedge clk_slow) begin
        q1 <= button;
        q2b <= ~(q1);
    end
    
    //And gate output
    assign out = q1 & q2b;

    ///!!!Do tasks... what happens when posedge/negedge out!!! ///

endmodule
