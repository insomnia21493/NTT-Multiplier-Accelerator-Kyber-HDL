LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE ieee.numeric_std.ALL; 
LIBRARY std;
USE std.standard.all;
LIBRARY work;
USE work.ALL;


ENTITY bf IS

	PORT(
	
	clk         :   IN 	std_logic;
	nrst        :   IN 	std_logic;
	
	bfmod		: 	IN  std_logic_vector(1 DOWNTO 0);
	
	rjin		: 	IN  std_logic_vector(11 DOWNTO 0);
	rjplin		: 	IN  std_logic_vector(11 DOWNTO 0);
	zeta 		: 	IN 	std_logic_vector(11 DOWNTO 0);
	
	rjout		: 	OUT std_logic_vector(11 DOWNTO 0);
	rjplout		: 	OUT std_logic_vector(11 DOWNTO 0)
	
	);


END bf;


ARCHITECTURE behaviour OF bf IS

	 COMPONENT modmul IS
		PORT(
			
			clk		: IN  std_logic;	
			nrst		: IN  std_logic;	
			A	:	IN		std_logic_vector(11 downto 0);
			B	:	IN		std_logic_vector(11 downto 0);
			R	:	OUT		std_logic_vector(11 downto 0)
			
		);
		END COMPONENT;
		
	 COMPONENT modsub IS
		PORT(
			
			A	:	IN		std_logic_vector(11 downto 0);
			B	:	IN		std_logic_vector(11 downto 0);
			C	:	OUT		std_logic_vector(11 downto 0)
				
		);
		END COMPONENT;
		
			
	 COMPONENT modadd IS
		PORT(
			
			A	:	IN		std_logic_vector(11 downto 0);
			B	:	IN		std_logic_vector(11 downto 0);
			C	:	OUT		std_logic_vector(11 downto 0)
					
		);
		END COMPONENT;
			
		
		
		SIGNAL amulwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL bmulwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL rmulwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL aaddwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL baddwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL caddwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL asubwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL bsubwire  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL csubwire  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL temp  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL reg0  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL reg1  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL reg2  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL reg3  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL reg4  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL reg5  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL reg5inwire  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL reg6  	  : std_logic_vector(11 DOWNTO 0);
		SIGNAL reg6inwire  	  : std_logic_vector(11 DOWNTO 0);
		
		SIGNAL reg7  	  : std_logic_vector(11 DOWNTO 0);
		

		

				
BEGIN
	

	bfc_modmul :  modmul PORT MAP( clk => clk , nrst => nrst, A => amulwire , B => bmulwire  , R => rmulwire );
	
	bfc_modadd: modadd PORT MAP( A => aaddwire , B => baddwire , C => caddwire );
	
	bfc_modsub: modsub PORT MAP( A => asubwire , B => bsubwire , C =>  csubwire );
	
	
	amulwire <= reg6 when bfmod="10" else rjplin;
	
	bmulwire <= reg7 when bfmod="10" else zeta when bfmod="00" else rjin;
	
	
	aaddwire <= reg5 when bfmod="00" else rjin;
	
	baddwire <= reg6 when bfmod="00" else rjplin;
	
	
	asubwire <= rjplin when bfmod="10" else reg6;
	
	bsubwire <= rjin when bfmod="10" else reg5;
	
	reg5inwire <= rmulwire when bfmod="00" else caddwire;
	
	reg6inwire <= reg4 when bfmod="00" else csubwire;
	
	temp <= rjin when bfmod="00" else reg5;
	
	rjout <=  reg4 when bfmod="10" else caddwire ;
	
	rjplout <= csubwire when bfmod="00" else rmulwire;
	
	
	
	
	
PROCESS(clk)
  BEGIN
  
	IF  clk'EVENT AND clk = '1' THEN
		IF nrst = '0' THEN

			reg0 <= (others =>'0');
			reg1 <= (others =>'0');
			reg2 <= (others =>'0');
			reg3 <= (others =>'0');
			reg4 <= (others =>'0');
			reg5 <= (others =>'0');
			reg6 <= (others =>'0');
			reg7 <= (others =>'0');

		ELSIF nrst='1' THEN
			
			reg0 <= temp;
			reg1 <= reg0;
			reg2 <= reg1;
			reg3 <= reg2;
			reg4 <= reg3;
			
			reg5 <= reg5inwire;
			
			reg6 <= reg6inwire;
			
			reg7 <= zeta;
		
		END IF;
		
	END IF;   

END PROCESS;	
	
	
	
	
	
	
	
			
END behaviour;
