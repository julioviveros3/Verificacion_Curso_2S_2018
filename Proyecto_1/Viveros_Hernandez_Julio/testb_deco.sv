//`timescale 1ns / 100ps

  module Test_decoder_4to8;
//*********************************************************  
    logic  [7:0] bcd; //señal recibida modulo
    logic   [3:0] binary,cuenta2; //señales enviadas al modulo
    logic [4:0] cuenta, memory1, memory2; //variables q modificare en el testbench
    logic [11:0] prueba;
    
     logic   en;
     // Instantiate the Decoder (named DUT {device under test})
    decoder_4to8  DUT(bcd, binary, en);
     initial  begin
       //prueba inicial de señales
        $timeformat(-9, 1, " ns", 6); #1;
       binary = 4'b0000;
       cuenta=5'b00000;
       prueba= 7'b0;
       
       #1
       
       en=1'b1; 
       #1
      
       
       while (cuenta<5'b10000) begin //empieza la cuenta y seimpre q sea menor q 10000
         #1
         if (binary<=cuenta)begin
         $display("binary: %b", binary);
         $display("BCD: %b", bcd);
         prueba=7'b0+binary;  
        cuenta2=0;  
         #1
             
           $display("prueba1: %b", prueba);
           
           while (cuenta2!=4) begin//cuenta utilizando cuenta2 para el corrimiento de 4 espacios para el algoritmo utilizado
             memory1=prueba[7:4];//utilizo esta memory1 para tener el valor de los 4 valores mas significativos 
               //$display("memory: %b", memory1);
             if (memory1<=4) begin//corrimiento de 4 espacios para el algoritmo utilizado, se ocupa q los 4 valores mas significativos de prueba, que ahora estan en memory1, tengan un valor de 4 maximo
             
             prueba=prueba<<1;
             memory1=prueba[7:4];
                 $display("memory: %b", memory1);
             //$display("prueba2: %b", prueba);
             cuenta2=cuenta2+1;
             //$display("cuenta2: %b", cuenta2);
                 
            
           end
             else begin //si el valor de memory1 llega a ser mayor a 4 entonces este tiene q hacer una suma de 0011 a estos cuatro valores mas significativos de q salieron de prueba
               memory1=memory1+4'b0011;
               prueba[7:4]=memory1[3:0];//una vez q se hace la suma estos 4 valores se agregan nuevamente a prueba para q siga haciendo el corrimiento
               prueba=prueba<<1;
               memory1=prueba[8:4];
               $display("memory: %b", memory1);
               $display("prueba3: %b", prueba);
               cuenta2=cuenta2+1;
               //$display("cuenta2: %b", cuenta2);
               
             end
               
               
           
           
         end
           if (memory1==bcd) begin;
             $display ("CORRECTO", " memoria: %b", memory1, " bcd: %b", bcd);
                 end
                 else
                   $display ("INCORRECTO");
         
            end  
         
      else begin
         en=0;
      end
         binary=binary+1;
           cuenta=cuenta+1;
      end
     end
  endmodule

    