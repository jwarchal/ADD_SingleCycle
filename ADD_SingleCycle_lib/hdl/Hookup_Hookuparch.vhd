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
  clock,reset: IN std_logic);
  
END ENTITY Hookup;

--
ARCHITECTURE Hookuparch OF Hookup IS
  
  --PC crap
  SIGNAL PCin, PCout, PCincrement: std_logic_vector(15 DOWNTO 0);
  SIGNAL jump: std_logic_vector(15 DOWNTO 0);
  CONSTANT zero: std_logic_vector(15 DOWNTO 0):= "0000000000000000";
  CONSTANT one: std_logic_vector(15 DOWNTO 0):= "0000000000000001";
  
  --Memory Signals
  SIGNAL Mem_w_en: std_logic;
  SIGNAL Mem_RWaddr: std_logic_vector(15 DOWNTO 0);
  
  --Register File
  SIGNAL RF_w_en: std_logic;
  SIGNAL RD0, RD1: std_logic_vector(15 DOWNTO 0);
  --RA0??
  
  --Extend Block
  SIGNAL ZEXT_L, ZEXT_R, SEXT: std_logic_vector(15 DOWNTO 0);
  
  --ALU signals
  SIGNAL Left, Right, ALUout: std_logic_vector(15 DOWNTO 0);
  SIGNAL cin: std_logic; --what is this?
  SIGNAL CCRvector: std_logic_vector(3 DOWNTO 0); --Didnt do this yet
  
  --Controls
  SIGNAL PCMUX_control, MemMux_control: std_logic;
  SIGNAL LMUX_control, RMUX_control: std_logic_vector(1 DOWNTO 0);
  
BEGIN
  PCMUX: ENTITY work.mux2to1(mux2to1arch)
  PORT MAP(jump,PCincrement,PCin,PCMUX_control);
    
  PC: ENTITY work.PC(PCarch)
  PORT MAP(PCin, PCout, clock, '1');
    
  Increment: ENTITY work.Increment(Incrementarch)
  PORT MAP(PCout, PCincrement);
  
  MemMux: ENTITY work.mux2to1(mux2to1arch)
  PORT MAP(ALUout,PCout,Mem_RWaddr,MemMux_control);
    
  Memory: ENTITY work.easy_RAM_simu(behavior)
  PORT MAP(reset,RD0,Mem_w_en,Mem_RWaddr,inst);
    
  Extendblock: ENTITY work.Extendblock(Extendblockarch)
  PORT MAP(inst, ZEXT_L, ZEXT_R, SEXT);
  
  RF: ENTITY work.RegisterFile(Behavior)
  PORT MAP(RF_w_en, ALUout, inst(12 DOWNTO 9), inst(8 DOWNTO 0), RD0, RD1);
    
  LeftMUX: ENTITY work.mux4to1(mux4to1arch)
  PORT MAP(ZEXT_L, ZEXT_R, SEXT, RD0, Left, LMUX_control);
    
  RightMUX: ENTITY work.mux4to1(mux4to1arch)
  PORT MAP(zero, RD1, zero, PCout, Right, RMUX_control);
    
  ALU: ENTITY work.alu(aluarch)
  PORT MAP(Left, Right, inst(14 DOWNTO 13) & inst(2 DOWNTO 0), cin, ALUout, CCRvector);
    
  Control: ENTITY work.ControlUnit(Behavior)
  PORT MAP(inst, CCRvector, PCMUX_control, RMUX_control, LMUX_control, MemMux_control);

END ARCHITECTURE Hookuparch;

