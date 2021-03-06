--
-- VHDL Architecture my_project_lib.ram_delay.behavior
--
--
-- Created:
--          by - dm5jc.UNKNOWN (LENOVO)
--          at - 08:09:23 03/ 1/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
--USE ieee.numeric_std.all;
USE ieee.math_real.all;


ENTITY ram_delay_V2 IS
  port( 
	  rst   : in	std_logic;                       -- active-high reset
	  hDIn  : in	std_logic_vector (63 DOWNTO 0);  -- data to memory
	  wr    : in	std_logic;                       -- memory write control signal
	  rd    : in	std_logic;                       -- memory read control signal
	  hAddr : in	std_logic_vector (15 DOWNTO 0);  -- memory address
	  hDOut : out	std_logic_vector (63 DOWNTO 0);   -- data from memory
	  ack    : out	std_logic                      -- acknowledge signal from memory
  );
END ENTITY ram_delay_V2;

--
ARCHITECTURE behavior OF ram_delay_V2 IS
  subtype table_address is integer range 0 to 15;
  SIGNAL tempval : std_logic_vector(63 DOWNTO 0);
  SIGNAL address : std_logic_vector (15 DOWNTO 0);
  
begin
  process(hAddr,hDIn,wr,rd,rst)
	  type counter_array is array (0 to 65535) of std_logic_vector(63 downto 0);
	  variable table : counter_array;
	  variable table_index: integer;
    variable seed1, seed2: positive;               -- Seed values for random generator
    variable rand: real;                           -- Random real-number value in range 0 to 1.0
    variable delay: time;                           -- delay in main memory
   
  begin
    ack <= '0';
    address <= "0000000000000000";
    address (13 DOWNTO 0) <= hAddr (15 DOWNTO 2);
    table_index := CONV_INTEGER(unsigned(address));
    UNIFORM(seed1, seed2, rand);
    delay := (rand*0.0000001)*10 sec;              -- random delay between 0 and 1000 ns
	  if (rst = '1') then
		  table := (others => (others => '0'));
table(0) := To_stdlogicvector(X"0000000000000000");
table(1) := To_stdlogicvector(X"0000000000000002");
table(2) := To_stdlogicvector(X"000000000000821E");
table(3) := To_stdlogicvector(X"0000000000008300");
table(4) := To_stdlogicvector(X"000000000000841F");
table(5) := To_stdlogicvector(X"0000000000008500");
table(6) := To_stdlogicvector(X"0000000000002620");
table(7) := To_stdlogicvector(X"0000000000002840");
table(8) := To_stdlogicvector(X"0000000000008000");
table(9) := To_stdlogicvector(X"0000000000008100");
table(10) := To_stdlogicvector(X"0000000000007E60");
table(11) := To_stdlogicvector(X"000000000000BE02");
table(12) := To_stdlogicvector(X"000000000000E311");
table(13) := To_stdlogicvector(X"0000000000007E80");
table(14) := To_stdlogicvector(X"000000000000BE02");
table(15) := To_stdlogicvector(X"000000000000E30E");
table(16) := To_stdlogicvector(X"0000000000008A01");
table(17) := To_stdlogicvector(X"0000000000008B00");
table(18) := To_stdlogicvector(X"0000000000007E00");
table(19) := To_stdlogicvector(X"000000000000BE82");
table(20) := To_stdlogicvector(X"000000000000E503");
table(21) := To_stdlogicvector(X"000000000000A062");
table(22) := To_stdlogicvector(X"000000000000A082");
table(23) := To_stdlogicvector(X"000000000000A060");
table(24) := To_stdlogicvector(X"000000000000A8A2");
table(25) := To_stdlogicvector(X"0000000000007E80");
table(26) := To_stdlogicvector(X"000000000000BEA2");
table(27) := To_stdlogicvector(X"000000000000E502");
table(28) := To_stdlogicvector(X"000000000000E1FB");
table(29) := To_stdlogicvector(X"000000000000E100");
table(30) := To_stdlogicvector(X"0000000000000003");
table(31) := To_stdlogicvector(X"0000000000000002");


          elsif (wr = '1' and rd = '0') then
            IF (hAddr(1 DOWNTO 0) = "11") THEN
              tempval <= table(table_index);
              tempval (63 DOWNTO 48) <= hDIn(63 DOWNTO 48);
              table(table_index) := tempval;
              hDOut <= tempval after delay;
              ack <= '1' after delay;
            ELSIF (hAddr (1 DOWNTO 0) = "10") THEN
              tempval <= table(table_index);
              tempval (47 DOWNTO 32) <= hDIn(47 DOWNTO 32);
              table(table_index) := tempval;
              hDOut <= tempval after delay;
              ack <= '1' after delay;
            ELSIF (hAddr (1 DOWNTO 0) = "01") THEN
              tempval <= table(table_index);
              tempval (31 DOWNTO 16) <= hDIn(31 DOWNTO 16);
              table(table_index) := tempval;
              hDOut <= tempval after delay;
              ack <= '1' after delay;
            ELSE
              tempval <= table(table_index);
              tempval (15 DOWNTO 0) <= hDIn(15 DOWNTO 0);
              table(table_index) := tempval;
              hDOut <= tempval after delay;
              ack <= '1' after delay;
            END IF;
            
          elsif (rd = '1' and wr = '0') then
	          tempval <= table(table_index);       
            hDOut <= tempval after delay;
            ack <= '1' after delay;
	  end if;
  end process;
END ARCHITECTURE behavior;


