LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL; 
LIBRARY std;
USE std.standard.all;
LIBRARY work;
USE work.ALL;


ENTITY modmul IS

	PORT(
    
    clk		: IN  std_logic;	
    nrst		: IN  std_logic;	
	A	:	IN		std_logic_vector(11 downto 0);
	B	:	IN		std_logic_vector(11 downto 0);
	R	:	OUT		std_logic_vector(11 downto 0)

	
	);


END modmul;

ARCHITECTURE behaviour OF modmul IS


COMPONENT in767 IS
		PORT(
			clk		: IN  std_logic;					
			nrst	: IN  std_logic;					
			b		: IN  std_logic_vector(11 DOWNTO 0);
			b767	: OUT  std_logic_vector(11 DOWNTO 0)
			
		);
		END COMPONENT;

COMPONENT intmul IS
		PORT(
							
			A		: IN  std_logic_vector(11 DOWNTO 0);
			B		: IN  std_logic_vector(11 DOWNTO 0);
			P		: OUT  std_logic_vector(23 DOWNTO 0)
			
		);
		END COMPONENT;

COMPONENT k2red IS
		PORT(
			
			clk		: IN  std_logic;
			nrst	: IN  std_logic;
			a		: IN  std_logic_vector(23 DOWNTO 0);
			p		: OUT  std_logic_vector(11 DOWNTO 0)
			
		);
		END COMPONENT;





		SIGNAL btemp  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL A1  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL A2  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL ptemp  	  : std_logic_vector(23 DOWNTO 0);

		
		SIGNAL preg  	  : std_logic_vector(23 DOWNTO 0);
		
		SIGNAL breg  	  : std_logic_vector(11 DOWNTO 0);

				
BEGIN

		myin767 : in767 PORT MAP (
			clk => clk,		
			nrst => nrst,		
			b	=> B,
			b767=> btemp 
		);
		
		
		myintmul : intmul PORT MAP (		
			A	=> A2,
			B	=> breg, 
			P	=> ptemp 
		);
		
		myk2red : k2red PORT MAP (	
			clk => clk,
			nrst => nrst,
			a	=> preg,
			p	=> R
		);
		
--breg <= btemp;			
			
PROCESS(clk)
  BEGIN
  
	IF  clk'EVENT AND clk = '1' THEN
		IF nrst = '0' THEN

			preg <= (others =>'0');
			breg <= (others =>'0');
			A1 <= (others =>'0');
			A2 <= (others =>'0');

		ELSIF nrst='1' THEN 
			preg <= ptemp;
			
			breg <= btemp;
			
			A1 <= A;
			
			A2 <= A1;
		
		END IF;
	
	END IF;
  
  END PROCESS;
	
	------
			
END behaviour;
