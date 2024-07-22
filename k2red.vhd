LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE ieee.numeric_std.ALL; 
LIBRARY std;
USE std.standard.all;
LIBRARY work;
USE work.ALL;

ENTITY k2red IS

	PORT(
		
		clk		: IN  std_logic;
		nrst	: IN  std_logic;
		a		: IN  std_logic_vector(23 DOWNTO 0);
		p		: OUT  std_logic_vector(11 DOWNTO 0)
	);


END k2red;

ARCHITECTURE behaviour OF k2red IS



		
        SIGNAL temp  : std_logic_vector(8 DOWNTO 0);
        SIGNAL temp0  : std_logic_vector(12 DOWNTO 0);
        SIGNAL temp1  : std_logic_vector(12 DOWNTO 0);
		
        SIGNAL temp2  : std_logic_vector(16 DOWNTO 0);
        SIGNAL temp2reg  : std_logic_vector(16 DOWNTO 0);
		
        SIGNAL stemp  : std_logic_vector(16 DOWNTO 0);
		
        SIGNAL stempreg  : std_logic_vector(16 DOWNTO 0);
        
		SIGNAL stemp16  : std_logic_vector(8 DOWNTO 0);
		
        SIGNAL temp3  : std_logic_vector(12 DOWNTO 0);
        SIGNAL temp4  : std_logic_vector(12 DOWNTO 0);
        SIGNAL temp5  : std_logic_vector(13 DOWNTO 0);
        
        SIGNAL temp5reg  : std_logic_vector(13 DOWNTO 0);
        
        SIGNAL temp6  : std_logic_vector(13 DOWNTO 0);
        SIGNAL temp7  : std_logic_vector(13 DOWNTO 0);
        SIGNAL s  : std_logic;
        SIGNAL sreg  : std_logic;
		
        
BEGIN
		
		temp <= '0' & a(7 DOWNTO 0);
		
		temp0 <=  ('0' & temp & "000")+ ("00" & temp & "00");
		temp1 <=  temp0 + ("000" & temp );
		
		temp2reg <=  temp1 - ('0' & a(23 DOWNTO 8)); 
	
	
		sreg <= temp2(16);
		stemp <= -temp2 when temp2(16) = '1' else temp2;
		
		stemp16 <= '0' & stemp(3 DOWNTO 0) & "0000";

		temp3 <= ('0' & stemp16 & "000")+ ("00" & stemp16 & "00");
		temp4 <= temp3 + ("000" & stemp16 );
		 
		temp5reg <= temp4 - ('0' & stemp(16 DOWNTO 4));
		
		temp6 <= -temp5 when s = '1' else temp5;
		
		temp7 <= temp6 + "0110100000001"  when temp6(13)  = '1' else temp6;
		
		p <= temp7(11 downto 0);
		
		
PROCESS(clk)
  BEGIN
  
  IF  clk'EVENT AND clk = '1' THEN
		
		IF nrst = '0' THEN

			temp2 <= (others =>'0');
			temp5 <= (others =>'0');
			s	<=	'0';

		ELSIF nrst='1' THEN
		
		
			temp2<= temp2reg;
		
			temp5 <= temp5reg;
			
			s	<=	sreg;
		
		END IF;
		
	END IF;
  

          
          
          
  END PROCESS;
	

		
END behaviour;