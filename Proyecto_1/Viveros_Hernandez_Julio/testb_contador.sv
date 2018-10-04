module tb_contador;
  logic clk, reset, updown;
  logic [3:0] act, n;//act es el valor enviado por el modulo, n una cuenta interna,
  logic [8:0] c; //c para cantidad de repeticiones
  logic [3:0] out ;//la salida del modulo 
  
  
  contador DUT(clk, reset, act, out, updown);
  initial begin 
    //esta parte es para comprobar algunos valores iniciales
    clk=0;
    
    reset=0;
    act=clk;
    n=0;
    updown=0;
    #1
    
    reset=1;
    updown=1;
    clk=1;
    
    #1;
    
    $display("Contador: %b", out);
    $display("act: %b", act);
    $display("n: %d", n);
    $display("Tiempo: %t", $time);
    $display("Contador: %b", out);
    reset=0;
    
    c=0;
      
    while (reset==0 & c<=70)begin //mientras el reset no este activado y c sea menos a 70, esto permite q haga unas 3 cuentas progresivas y 2 regresivas
       
        if (updown==1) begin //updown esta on entonces hace cuenta progresiva
          if (act==15)begin //si el contador llega a 15 entonces el updown se niega y pasa a cuenta regresiva
         updown=0;
         $display("Updown: %b", updown);
       end
       else   
          
         if (act==0 & n!=15)begin //aqui voy a hacer el inicio de la cuenta cuando este va a empezar a contar progresivamente
          #1
           c=c;
          clk=0;
          act=0;
          $display("Inicio contador1: %b", out);
          clk=1;
          c=c+1; 
          n=n+1;
          act=out;
          $display("n: %d", n);
          $display("act: %b", act);
           $display("c: %d", c); 
           if(out==n)begin//compara lo q me llega del diseño con la cuenta interna
                $display("Correcto");
                end
         
                 else
                 $display("Incorrecto");
                 $display("Tiempo: %t", $time);
          end
                
          else while (n!=0000 & n!=15)begin //la cuenta interna mientras no sea ni 0 ni 15, en el momento q llegue a 15 entonces el updown se vuelve 0 y pasa a cuenta regresiva
          #1
          clk=0;
          act=out;
          $display("Inicio contador2: %b", out);
          $display("act: %b", act);
         
          clk=1;
          n=n+1;
         c=c+1;
         $display("c: %d", c); 
          $display("n: %d", n);
              if(out==n)begin
              $display("Correcto");
              end
              else
              $display("Incorrecto");
              $display("Tiempo: %t", $time);
      
          end
                
       
       
       
     end
      else //esta parte es la cuenta regresiva
        if (act==0)begin
         updown=1;
         $display("Updown: %b", updown);
       end
       else   
          
         if (act==15 & n!=0)begin
          #1
          c=c;
          clk=0;
          act=0;
          $display("Inicio contador1: %b", out);
          clk=1;
          n=n-1;
           c=c+1;
          act=out;
          $display("n: %d", n);
          $display("act: %b", act);
           $display("c: %d", c); 
                 if(out==n)begin
                $display("Correcto");
                end
         
                 else
                 $display("Incorrecto");
                 $display("Tiempo: %t", $time);
          end
                
      else while (n!=15 & n!=0)begin
          #1
          clk=0;
          act=out;
          $display("Inicio contador2: %b", out);
          $display("act: %b", act);
        
          clk=1;
          n=n-1;
        c=c+1;
        $display("c: %d", c); 
          $display("n: %d", n);
              if(out==n)begin
              $display("Correcto");
              end
              else
              $display("Incorrecto");
              $display("Tiempo: %t", $time);
      
          end
    end
  
    end
    
  
endmodule