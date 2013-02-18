--
-- VHDL Architecture ADD_SingleCycle_lib.RegisterFile.Behavior
--
-- Created:
--          by - Administrator.UNKNOWN (PETERLAI-LEE71B)
--          at - 08:24:10 02/ 8/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
-- REGISTER FILE

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY RegisterFile IS
  PORT(clock, w_en: IN std_logic;
    wd: IN std_logic_vector(15 DOWNTO 0);
    --ra0=dest reg addr(12:9)  ra1=src reg addr(8:5)
    wa, ra0, ra1: IN std_logic_vector(3 DOWNTO 0);
    rd0, rd1: OUT std_logic_vector(15 DOWNTO 0));

END ENTITY RegisterFile;


ARCHITECTURE Behavior OF RegisterFile IS
  
BEGIN
  
		PROCESS(clock, w_en, wd, wa, ra0, ra1)
				
		--creates regfile of 16, 16-bit registers
		TYPE reg_file_arr IS ARRAY(15 DOWNTO 0) OF std_logic_vector(15 DOWNTO 0); 
    VARIABLE reg_file: reg_file_arr;
    
		BEGIN	
				--reads data from regfile
        rd0 <= reg_file(Conv_INTEGER(unsigned(ra0)));
        rd1 <= reg_file(Conv_INTEGER(unsigned(ra1)));
        
   			  --writes data to writeaddr(wa) if write enable(w_en) is 1
   			  IF (w_en = '1' AND rising_edge(clock)) THEN
			  reg_file(Conv_INTEGER(unsigned(wa))) := wd;
			  END IF;
			  
		END PROCESS;
		
END ARCHITECTURE Behavior;