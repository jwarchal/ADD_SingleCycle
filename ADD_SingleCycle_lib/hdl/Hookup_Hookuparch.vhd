--
-- VHDL Architecture ADD_SingleCycle_lib.Hookup.Hookuparch
--
-- Created:
--          by - Vincent.UNKNOWN (VINCENT-LAPTOP)
--          at - 15:04:40 02/11/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Hookup IS
  PORT(jump: IN std_logic_vector(15 DOWNTO 0);
  clock: IN std_logic);
  
END ENTITY Hookup;

--
ARCHITECTURE Hookuparch OF Hookup IS
  SIGNAL PCin, PCout, PCincrement: std_logic_vector(15 DOWNTO 0);
  SIGNAL jump: std_logic_vector(15 DOWNTO 0);
  CONSTANT zero: std_logic_vector(15 DOWNTO 0):= "0000000000000000";
  CONSTANT one: std_logic_vector(15 DOWNTO 0):= "0000000000000001";
  -- NEED DataMem, RFin
  -- PCMUXcontrol, RFMUXControl
  
  
  --ALU signals
  SIGNAL Left, Right, ALUout: std_logic_vector(15 DOWNTO 0);
  SIGNAL opcode: std_logic_vector(4 DOWNTO 0);
  SIGNAL cin: std_logic;
  SIGNAL CCRvector: std_logic_vector(3 DOWNTO 0);
BEGIN
  PCMUX: ENTITY work.mux2to1(mux2to1arch)
  PORT MAP(jump,PCincrement,PCin,PCMUXcontrol);
    
  PC: ENTITY work.PC(PCarch)
  PORT MAP(PCin, PCout, clock, '1');
    
  Increment: ENTITY work.Increment(Incrementarch)
  PORT MAP(PCout, PCincrement);
    
  RFMUX: ENTITY work.mux2to1(mux2to1arch)
  PORT MAP(DataMem, ALUout, RFin, RFMUXcontrol);
  
  --RF: ENTITY work.RegisterFile(Behavior)
  
  --LeftMUX: ENTITY work.mux4to1(mux4to1arch)
  --PORT MAP();
    
  --RightMUX: ENTITY work.mux4to1(mux4to1arch)
  --PORT MAP();
    
  ALU: ENTITY work.alu(aluarch)
  PORT MAP(Left, Right, opcode, cin, ALUout, CCRvector);
  
  
END ARCHITECTURE Hookuparch;

