LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MUX_2x1 IS
	PORT (
		input : IN STD_LOGIC_VECTOR (1 downto 0);
		S : IN STD_LOGIC;
		R : OUT STD_LOGIC
	);
END;

ARCHITECTURE struct OF MUX_2x1 IS
SIGNAL int_sig : STD_LOGIC_VECTOR (1 downto 0);
BEGIN
	int_sig(0) <= input(0) NAND (NOT S);
	int_sig(1) <= input(1) NAND S;
	R <= int_sig(0) NAND int_sig(1);
END struct;