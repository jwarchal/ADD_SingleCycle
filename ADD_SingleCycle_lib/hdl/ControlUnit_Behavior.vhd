--
-- VHDL Architecture ADD_SingleCycle_lib.ControlUnit.Behavior
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 16:40:35 02/ 5/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ControlUnit IS
  
  PORT (InstMem : IN std_logic_vector (15 DOWNTO 0);
        ConditionCode: IN std_logic_vector (3 DOWNTO 0);
        PC_mux, ALU_R_mux, ALU_L_mux : OUT std_logic_vector (1 DOWNTO 0);
        RF_mux, DM_e, RF_e : OUT std_logic );
        
END ENTITY ControlUnit;

--
ARCHITECTURE Behavior OF ControlUnit IS
  
BEGIN
  PROCESS (InstMem, ConditionCode)
    VARIABLE topBits : std_logic_vector (2 DOWNTO 0);
    VARIABLE eightBit: std_logic;
    VARIABLE bottomBit: std_logic_vector (2 DOWNTO 0);
    VARIABLE twelveToNine: std_logic_vector (3 DOWNTO 0);
  BEGIN
    topBits := InstMem(15 DOWNTO 13); 
    eightBit := InstMem (8);
    bottomBit := InstMem(2 DOWNTO 0);
    twelveToNine := InstMem(12 DOWNTO 9); 
    
    --NOP
    IF (topBits = "000") THEN
      PC_mux <=  "11";
      RF_mux <= '0';
      ALU_L_mux <= "00";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '0';
    END IF;
    
    --LD
    IF (topBits = "001") THEN
      PC_mux <= "11"; 
      RF_mux <= '1';
      ALU_L_mux <= "01";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '1';
    END IF;
    
    --ST
    IF (topBits = "010") THEN
      PC_mux <=  "11";
      RF_mux <= '1';
      ALU_L_mux <= "01";
      ALU_R_mux <= "00";
      DM_e <= '1';
      RF_e <= '0';
    END IF;
    
    --MOV
    IF (topBits = "011") THEN 
      PC_mux <=  "11";
      RF_mux <= '0';
      ALU_L_mux <= "00";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '1';
    END IF;
    
    --LIL, LIH
    IF (topBits = "100" AND eightBit = '0') THEN
      PC_mux <=  "11";
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "10";
      DM_e <= '0';
      RF_e <='1';
    ELSIF (eightBit = '1') THEN
      PC_mux <=  "11";
      RF_mux <= '0';
      ALU_L_mux <= "11";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '1';  
    END IF;
    
    --ADD, ADC, SUB, ABC, AND, OR, XOR, NOT
    IF (topBits = "101") THEN
      PC_mux <=  "11";
      RF_mux <= "00";
      ALU_L_mux <= "00";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '1';
    END IF;
    
    --SL, SRL, SRA, RRA, RR, RL
    IF (topBits = "110" ) THEN
      PC_mux <=  "11";
      RF_mux <= "00";
      ALU_L_mux <= "00";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '1';
    END IF;
    
    --JMP
    IF (topBits = "111"  AND eightBit = "0") THEN
      PC_mux <=  "00";
      RF_mux <= "00";
      ALU_L_mux <= "01";
      ALU_R_mux <= "00";
      DM_e <= '0';
      RF_e <= '0';
      
    --BR
    ELSIF ( twelveToNine = "0000") THEN
      PC_mux <=  "01";
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "01";
      DM_e <= '0';
      RF_e <= '0';
    
    --BC
    ELSIF ( twelveToNine = ConditionCode ) THEN
      PC_mux <=  "01";
      RF_mux <= '0';
      ALU_L_mux <= "01";
      ALU_R_mux <= "01";
      DM_e <= '0';
      RF_e <= '0';
    END IF;
    
  END PROCESS;
END ARCHITECTURE Behavior;

