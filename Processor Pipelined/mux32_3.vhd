LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY mux32_3 IS
	PORT(
		a	: IN STD_LOGIC_VECTOR(31 downto 0);
		b	: IN STD_LOGIC_VECTOR(31 downto 0);
		c	: IN STD_LOGIC_VECTOR(31 downto 0);
		d	: IN STD_LOGIC_VECTOR(31 downto 0);
		e	: IN STD_LOGIC_VECTOR(31 downto 0);
		f	: IN STD_LOGIC_VECTOR(31 downto 0);
		s 	: IN STD_LOGIC_VECTOR(2 downto 0);
		y 	: OUT STD_LOGIC_VECTOR(31 downto 0));
END mux32_3;


ARCHITECTURE struct OF mux32_3 IS

	SIGNAL int_mux_OUT   :  STD_LOGIC_VECTOR(31 downto 0);
	
COMPONENT MUX_8x1 IS
	PORT(
		i_input			: IN	STD_LOGIC_VECTOR(7 downto 0);
		s			: IN 	STD_LOGIC_VECTOR(2 downto 0);
		o_output		: OUT	STD_LOGIC);
END COMPONENT;

BEGIN
	--Component Setup
	mux0: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(0),
		i_input(1)	=>b(0),
		i_input(2)	=>c(0),
		i_input(3)	=>d(0),
		i_input(4)	=>e(0),
		i_input(5)	=>f(0),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(0) );

	mux1: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(1),
		i_input(1)	=>b(1),
		i_input(2)	=>c(1),
		i_input(3)	=>d(1),
		i_input(4)	=>e(1),
		i_input(5)	=>f(1),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(1) );

	mux2: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(2),
		i_input(1)	=>b(2),
		i_input(2)	=>c(2),
		i_input(3)	=>d(2),
		i_input(4)	=>e(2),
		i_input(5)	=>f(2),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(2) );

	mux3: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(3),
		i_input(1)	=>b(3),
		i_input(2)	=>c(3),
		i_input(3)	=>d(3),
		i_input(4)	=>e(3),
		i_input(5)	=>f(3),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(3) );

	mux4: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(4),
		i_input(1)	=>b(4),
		i_input(2)	=>c(4),
		i_input(3)	=>d(4),
		i_input(4)	=>e(4),
		i_input(5)	=>f(4),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(4) );

	mux5: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(5),
		i_input(1)	=>b(5),
		i_input(2)	=>c(5),
		i_input(3)	=>d(5),
		i_input(4)	=>e(5),
		i_input(5)	=>f(5),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(5) );

	mux6: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(6),
		i_input(1)	=>b(6),
		i_input(2)	=>c(6),
		i_input(3)	=>d(6),
		i_input(4)	=>e(6),
		i_input(5)	=>f(6),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(6) );

	mux7: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(7),
		i_input(1)	=>b(7),
		i_input(2)	=>c(7),
		i_input(3)	=>d(7),
		i_input(4)	=>e(7),
		i_input(5)	=>f(7),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(7) );

	mux8: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(8),
		i_input(1)	=>b(8),
		i_input(2)	=>c(8),
		i_input(3)	=>d(8),
		i_input(4)	=>e(8),
		i_input(5)	=>f(8),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(8) );

	mux9: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(9),
		i_input(1)	=>b(9),
		i_input(2)	=>c(9),
		i_input(3)	=>d(9),
		i_input(4)	=>e(9),
		i_input(5)	=>f(9),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(9) );

	mux10: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(10),
		i_input(1)	=>b(10),
		i_input(2)	=>c(10),
		i_input(3)	=>d(10),
		i_input(4)	=>e(10),
		i_input(5)	=>f(10),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(10) );

	mux11: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(11),
		i_input(1)	=>b(11),
		i_input(2)	=>c(11),
		i_input(3)	=>d(11),
		i_input(4)	=>e(11),
		i_input(5)	=>f(11),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(11) );

	mux12: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(12),
		i_input(1)	=>b(12),
		i_input(2)	=>c(12),
		i_input(3)	=>d(12),
		i_input(4)	=>e(12),
		i_input(5)	=>f(12),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(12) );

	mux13: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(13),
		i_input(1)	=>b(13),
		i_input(2)	=>c(13),
		i_input(3)	=>d(13),
		i_input(4)	=>e(13),
		i_input(5)	=>f(13),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(13) );

	mux14: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(14),
		i_input(1)	=>b(14),
		i_input(2)	=>c(14),
		i_input(3)	=>d(14),
		i_input(4)	=>e(14),
		i_input(5)	=>f(14),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(14) );

	mux15: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(15),
		i_input(1)	=>b(15),
		i_input(2)	=>c(15),
		i_input(3)	=>d(15),
		i_input(4)	=>e(15),
		i_input(5)	=>f(15),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(15) );

	mux16: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(16),
		i_input(1)	=>b(16),
		i_input(2)	=>c(16),
		i_input(3)	=>d(16),
		i_input(4)	=>e(16),
		i_input(5)	=>f(16),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(16) );

	mux17: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(17),
		i_input(1)	=>b(17),
		i_input(2)	=>c(17),
		i_input(3)	=>d(17),
		i_input(4)	=>e(17),
		i_input(5)	=>f(17),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(17) );

	mux18: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(18),
		i_input(1)	=>b(18),
		i_input(2)	=>c(18),
		i_input(3)	=>d(18),
		i_input(4)	=>e(18),
		i_input(5)	=>f(18),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(18) );

	mux19: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(19),
		i_input(1)	=>b(19),
		i_input(2)	=>c(19),
		i_input(3)	=>d(19),
		i_input(4)	=>e(19),
		i_input(5)	=>f(19),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(19) );

	mux20: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(20),
		i_input(1)	=>b(20),
		i_input(2)	=>c(20),
		i_input(3)	=>d(20),
		i_input(4)	=>e(20),
		i_input(5)	=>f(20),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(20) );

	mux21: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(21),
		i_input(1)	=>b(21),
		i_input(2)	=>c(21),
		i_input(3)	=>d(21),
		i_input(4)	=>e(21),
		i_input(5)	=>f(21),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(21) );

	mux22: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(22),
		i_input(1)	=>b(22),
		i_input(2)	=>c(22),
		i_input(3)	=>d(22),
		i_input(4)	=>e(22),
		i_input(5)	=>f(22),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(22) );

	mux23: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(23),
		i_input(1)	=>b(23),
		i_input(2)	=>c(23),
		i_input(3)	=>d(23),
		i_input(4)	=>e(23),
		i_input(5)	=>f(23),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(23) );

	mux24: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(24),
		i_input(1)	=>b(24),
		i_input(2)	=>c(24),
		i_input(3)	=>d(24),
		i_input(4)	=>e(24),
		i_input(5)	=>f(24),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(24) );

	mux25: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(25),
		i_input(1)	=>b(25),
		i_input(2)	=>c(25),
		i_input(3)	=>d(25),
		i_input(4)	=>e(25),
		i_input(5)	=>f(25),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(25) );

	mux26: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(26),
		i_input(1)	=>b(26),
		i_input(2)	=>c(26),
		i_input(3)	=>d(26),
		i_input(4)	=>e(26),
		i_input(5)	=>f(26),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(26) );

	mux27: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(27),
		i_input(1)	=>b(27),
		i_input(2)	=>c(27),
		i_input(3)	=>d(27),
		i_input(4)	=>e(27),
		i_input(5)	=>f(27),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(27) );

	mux28: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(28),
		i_input(1)	=>b(28),
		i_input(2)	=>c(28),
		i_input(3)	=>d(28),
		i_input(4)	=>e(28),
		i_input(5)	=>f(28),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(28) );

	mux29: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(29),
		i_input(1)	=>b(29),
		i_input(2)	=>c(29),
		i_input(3)	=>d(29),
		i_input(4)	=>e(29),
		i_input(5)	=>f(29),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(29) );

	mux30: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(30),
		i_input(1)	=>b(30),
		i_input(2)	=>c(30),
		i_input(3)	=>d(30),
		i_input(4)	=>e(30),
		i_input(5)	=>f(30),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(30) );

	mux31: MUX_8x1
	PORT MAP(
		s		=>s,
		i_input(0)	=>a(31),
		i_input(1)	=>b(31),
		i_input(2)	=>c(31),
		i_input(3)	=>d(31),
		i_input(4)	=>e(31),
		i_input(5)	=>f(31),
		i_input(6)	=>'0',
		i_input(7)	=>'0',
		o_output	=>int_mux_OUT(31) );

	--Output Assignment
	y 	<= int_mux_OUT;
END struct;