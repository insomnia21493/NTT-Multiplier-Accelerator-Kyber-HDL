LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE ieee.numeric_std.ALL; 
LIBRARY std;
USE std.standard.all;
LIBRARY work;
USE work.ALL;

ENTITY in767 IS

	PORT(
		
		clk		: IN  std_logic;
		nrst	: IN  std_logic;
		b		: IN  std_logic_vector(11 DOWNTO 0);
		b767	: OUT  std_logic_vector(11 DOWNTO 0)
	);


END in767;

ARCHITECTURE behaviour OF in767 IS



		
        SIGNAL temp0  : std_logic_vector(18 DOWNTO 0);
        SIGNAL temp1  : std_logic_vector(18 DOWNTO 0);
        
        SIGNAL temp1reg  : std_logic_vector(18 DOWNTO 0);
		
		SIGNAL temp2  : std_logic_vector(8 DOWNTO 0);
		
        SIGNAL temp4  : std_logic_vector(12 DOWNTO 0);
        SIGNAL temp5  : std_logic_vector(12 DOWNTO 0);
        SIGNAL temp6  : std_logic_vector(12 DOWNTO 0);
        SIGNAL temp7  : std_logic_vector(12 DOWNTO 0);
		
		

				
BEGIN

		temp0 <= ('0' & b & "000000") - ( "00000" & b & "00");
		temp1reg <= temp0 - ("0000000" & b );
		
		temp2 <= '0' & temp1(7 DOWNTO 0);
		
		temp4 <= ('0' & temp2 & "000")+ ("00" & temp2 & "00");
		temp5 <= temp4 + ("000" & temp2 );
		
		temp6 <= temp5 -  ('0' & temp1(18 DOWNTO 8));
		
		temp7 <= temp6 + "0110100000001" when temp6(12) = '1' else temp6;
		
		b767 <= temp7(11 DOWNTO 0);


		
PROCESS(clk)
  BEGIN
  
  IF  clk'EVENT AND clk = '1' THEN
		
		IF nrst = '0' THEN

			temp1 <= (others =>'0');
			
		ELSIF nrst='1' THEN
	
			temp1 <= temp1reg; 
        
		END IF;
	
	END IF;      
          
  END PROCESS;
	
END behaviour;
