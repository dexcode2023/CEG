LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux21_5bit IS
	PORT (
		A, B  : IN STD_LOGIC_VECTOR (4 downto 0);
		S 		: IN STD_LOGIC;
		R 		: OUT STD_LOGIC_VECTOR (4 downto 0)
	);
END;

ARCHITECTURE struct OF mux21_5bit IS

COMPONENT MUX_2x1 IS
	PORT (
		input : IN STD_LOGIC_VECTOR (1 downto 0);
		S : IN STD_LOGIC;
		R : OUT STD_LOGIC
	);
END COMPONENT;

BEGIN

	MUX_0: MUX_2x1
	PORT MAP (
		  input(0) => A(0),
		  input(1) => B(0),
		  S => S,
		  R => R(0) );

	MUX_1: MUX_2x1
	PORT MAP (
		  input(0) => A(1),
		  input(1) => B(1),
		  S => S,
		  R => R(1) );

	MUX_2: MUX_2x1
	PORT MAP (
		  input(0) => A(2),
		  input(1) => B(2),
		  S => S,
		  R => R(2) );

	MUX_3: MUX_2x1
	PORT MAP (
		  input(0) => A(3),
		  input(1) => B(3),
		  S => S,
		  R => R(3) );

	MUX_4: MUX_2x1
	PORT MAP (
		  input(0) => A(4),
		  input(1) => B(4),
		  S => S,
		  R => R(4) );

END struct;












