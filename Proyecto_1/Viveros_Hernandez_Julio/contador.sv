module contador (clk, reset, act, out, updown);
  input logic clk, reset, updown;
  input logic [3:0] act;
  output logic [3:0]out;
  
   
  always @(posedge clk or negedge reset) begin
    
    
    out=act;
    if (reset==0)begin
       if (updown==1)begin 
      
       out=out+1;
      
      
      end
    
     else
          out=out-1;
    end
      
        else if(updown==1)begin
                out=0000;     
      end
        else
          out=1111;
    
  end
endmodule