LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY MUX_8x1 IS
	PORT(
		i_input			: IN	STD_LOGIC_VECTOR(7 downto 0);
		s			: IN 	STD_LOGIC_VECTOR(2 downto 0);
		o_output		: OUT	STD_LOGIC);
END MUX_8x1;

ARCHITECTURE struct OF MUX_8x1 IS
	SIGNAL int_inputSEL  :  STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_s_Bar :  STD_LOGIC_VECTOR(2 downto 0);

BEGIN

	--Signal Assignment
	int_s_Bar(0) <= NOT( s(0) );
	int_s_Bar(1) <= NOT( s(1) );
	int_s_Bar(2) <= NOT( s(2) );


	int_inputSEL(0) <= int_s_Bar(0) AND int_s_Bar(1) AND int_s_Bar(2) AND i_input(0);
	int_inputSEL(1) <= s(0)         AND int_s_Bar(1) AND int_s_Bar(2) AND i_input(1);
	int_inputSEL(2) <= int_s_Bar(0) AND s(1)         AND int_s_Bar(2) AND i_input(2);
	int_inputSEL(3) <= s(0)         AND s(1)         AND int_s_Bar(2) AND i_input(3);
	int_inputSEL(4) <= int_s_Bar(0) AND int_s_Bar(1) AND s(2)         AND i_input(4);
	int_inputSEL(5) <= s(0)         AND int_s_Bar(1) AND s(2)         AND i_input(5);
	int_inputSEL(6) <= int_s_Bar(0) AND s(1)         AND s(2)         AND i_input(6);
	int_inputSEL(7) <= s(0)         AND s(1)         AND s(2)         AND i_input(7);
	
	--Output Assignment
	o_output <= int_inputSEL(0) OR int_inputSEL(1) OR int_inputSEL(2) OR int_inputSEL(3) OR int_inputSEL(4) OR int_inputSEL(5) OR int_inputSEL(6) OR int_inputSEL(7);


end struct;
