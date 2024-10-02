LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY nineBitMultiplier IS
	PORT ( 
		i_A, i_B		: IN	STD_LOGIC_VECTOR(8 downto 0);
		o_cout			: OUT	STD_LOGIC;
		o_q			: OUT	STD_LOGIC_VECTOR(8 downto 0));
END nineBitMultiplier;

ARCHITECTURE rtl OF nineBitMultiplier IS

COMPONENT nineBitAdder
	PORT (	i_x			: IN STD_LOGIC_VECTOR(8 downto 0);
		i_y			: IN STD_LOGIC_VECTOR(8 downto 0);
		i_cin			: IN STD_LOGIC;
		o_cout			: OUT STD_LOGIC;
		o_q			: OUT STD_LOGIC_VECTOR(8 downto 0));
END COMPONENT;

SIGNAL int_x0, int_x1, int_x2, int_x3, int_x4, int_x5, int_x6, int_x7 : STD_LOGIC_VECTOR(8 downto 0);
SIGNAL int_y0, int_y1, int_y2, int_y3, int_y4, int_y5, int_y6, int_y7 : STD_LOGIC_VECTOR(8 downto 0);
SIGNAL int_s0, int_s1, int_s2, int_s3, int_s4, int_s5, int_s6, int_s7 : STD_LOGIC_VECTOR(8 downto 0);

SIGNAL int_c : STD_LOGIC_VECTOR(7 downto 0);

BEGIN

--first partial product
int_x0 <= ('0' & i_A(8 downto 1)) AND (i_B(0) & i_B(0) & i_B(0) & i_B(0) & i_B(0) & i_B(0) & i_B(0) & i_B(0) & i_B(0));
int_y0 <= i_A AND (i_B(1) & i_B(1) & i_B(1) & i_B(1) & i_B(1) & i_B(1) & i_B(1) & i_B(1) & i_B(1));

adder0: nineBitAdder
	PORT MAP (	i_x => int_x0,
			i_y => int_y0,
			i_cin => '0',
			o_cout => int_c(0),
			o_q => int_s0);

--second partial product
int_x1 <= int_c(0) & int_s0(8 downto 1);
int_y1 <= i_A AND (i_B(2) & i_B(2) & i_B(2) & i_B(2) & i_B(2) & i_B(2) & i_B(2) & i_B(2) & i_B(2));

adder1: nineBitAdder
	PORT MAP (	i_x => int_x1,
			i_y => int_y1,
			i_cin => '0',
			o_cout => int_c(1),
			o_q => int_s1);

--third partial product
int_x2 <= int_c(1) & int_s1(8 downto 1);
int_y2 <= i_A AND (i_B(3) & i_B(3) & i_B(3) & i_B(3) & i_B(3) & i_B(3) & i_B(3) & i_B(3) & i_B(3));

adder2: nineBitAdder
	PORT MAP (	i_x => int_x2,
			i_y => int_y2,
			i_cin => '0',
			o_cout => int_c(2),
			o_q => int_s2);

--fourth partial product
int_x3 <= int_c(2) & int_s2(8 downto 1);
int_y3 <= i_A AND (i_B(4) & i_B(4) & i_B(4) & i_B(4) & i_B(4) & i_B(4) & i_B(4) & i_B(4) & i_B(4));

adder3: nineBitAdder
	PORT MAP (	i_x => int_x3,
			i_y => int_y3,
			i_cin => '0',
			o_cout => int_c(3),
			o_q => int_s3);

--fifth partial product
int_x4 <= int_c(3) & int_s3(8 downto 1);
int_y4 <= i_A AND (i_B(5) & i_B(5) & i_B(5) & i_B(5) & i_B(5) & i_B(5) & i_B(5) & i_B(5) & i_B(5));

adder4: nineBitAdder
	PORT MAP (	i_x => int_x4,
			i_y => int_y4,
			i_cin => '0',
			o_cout => int_c(4),
			o_q => int_s4);

--sixth partial product
int_x5 <= int_c(4) & int_s4(8 downto 1);
int_y5 <= i_A AND (i_B(6) & i_B(6) & i_B(6) & i_B(6) & i_B(6) & i_B(6) & i_B(6) & i_B(6) & i_B(6));

adder5: nineBitAdder
	PORT MAP (	i_x => int_x5,
			i_y => int_y5,
			i_cin => '0',
			o_cout => int_c(5),
			o_q => int_s5);

--seventh partial product
int_x6 <= int_c(5) & int_s5(8 downto 1);
int_y6 <= i_A AND (i_B(7) & i_B(7) & i_B(7) & i_B(7) & i_B(7) & i_B(7) & i_B(7) & i_B(7) & i_B(7));

adder6: nineBitAdder
	PORT MAP (	i_x => int_x6,
			i_y => int_y6,
			i_cin => '0',
			o_cout => int_c(6),
			o_q => int_s6);

--eighth partial product
int_x7 <= int_c(6) & int_s6(8 downto 1);
int_y7 <= i_A AND (i_B(8) & i_B(8) & i_B(8) & i_B(8) & i_B(8) & i_B(8) & i_B(8) & i_B(8) & i_B(8));

adder7: nineBitAdder
	PORT MAP (	i_x => int_x7,
			i_y => int_y7,
			i_cin => '0',
			o_cout => int_c(7),
			o_q => int_s7);

	--Output drivers
	o_cout <= int_c(7);
	o_q <= int_s7;

END rtl;
