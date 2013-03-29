  --
  -- VHDL Architecture ADD_SingleCycle_lib.Inst_StateMachine.Behavior
  --
  -- Created:
  --          by - Rebecca.UNKNOWN (ATHENA)
  --          at - 10:25:43 02/25/2013
  --
  -- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
  --
  LIBRARY ieee;
  USE ieee.std_logic_1164.all;
  USE ieee.std_logic_arith.all;
  
  ENTITY Inst_StateMachine_V2 IS
    PORT ( clock, ifilled: IN std_logic;
           PC, instFromRAM: IN std_logic_vector (15 DOWNTO 0);
           instFromMem : IN std_logic_vector (63 DOWNTO 0);
           inst, addrToMem: OUT std_logic_vector (15 DOWNTO 0);
           MMdataToRAM: OUT std_logic_vector (63 DOWNTO 0);
           addr: OUT std_logic_vector (3 DOWNTO 0);
           slicer: OUT std_logic_vector (1 DOWNTO 0);
           idelay, ireq, intwe: OUT std_logic );
  END ENTITY Inst_StateMachine_V2;
  
  --
  ARCHITECTURE Behavior OF Inst_StateMachine_V2 IS
    TYPE state IS(hit_state, wait_state, limbo_state);
    TYPE tagarray IS ARRAY (0 TO 15) OF std_logic_vector(9 DOWNTO 0);
    SIGNAL current_state, next_state: state := hit_state;
    SIGNAL tags: tagarray ;
    SIGNAL currentinst: std_logic_vector(15 DOWNTO 0);
    BEGIN
      
    PROCESS(clock)
      BEGIN
          IF (rising_edge(clock)) THEN
            current_state <= next_state;
          END IF;
    END PROCESS;
  
    PROCESS(PC, ifilled)
    VARIABLE hit: std_logic := '0';
      BEGIN
        hit := '0'; --if hit=0 MISS in the cache, therefore, we need data from Main Mem.
        FOR i IN 0 TO 15 LOOP
          IF(tags(i) = PC(15 DOWNTO 6)) THEN
            hit := '1'; -- HIT! Retrieve data from cache
          END IF;
        END LOOP;
        
        --logic to simply change states.
        CASE current_state IS
            WHEN hit_state =>
            IF(hit = '1') THEN
              next_state <= hit_state;
            ELSE
              next_state <= limbo_state;
            END IF;
            WHEN wait_state =>
            IF(ifilled = '0') THEN
              next_state <= wait_state;
            ELSE
              next_state <= hit_state;
            END IF;
            WHEN limbo_state =>
              next_state <= wait_state;
        END CASE;
    END PROCESS;
  
    PROCESS(current_state)
      BEGIN
      
          CASE current_state IS
            WHEN hit_state =>
              addrToMem <= PC;
              idelay <= '0';
              ireq <= '0';
              intwe <= '0';
              addr <= PC(5 DOWNTO 2);
              slicer <= PC(1 DOWNTO 0);
              currentinst <= inst;
              inst <= instFromRAM;
              MMdataToRAM <= instFromMem;
            WHEN wait_state =>
              addrToMem <= PC;
              idelay <= '1';
              ireq <= '1';
              intwe <= '1';
              addr <= PC(5 DOWNTO 2);
              slicer <= PC(1 DOWNTO 0);
              inst <= currentinst;
              MMdataToRAM <= instFromMem;
              tags(Conv_integer(unsigned(PC(5 DOWNTO 2)))) <= PC(15 DOWNTO 6);
            WHEN limbo_state =>
              addrToMem <= PC;
              idelay <= '1';
              ireq <= '1';
              intwe <= '1';
              addr <= PC(5 DOWNTO 2);
              inst <= currentinst;
              MMdataToRAM <= instFromMem;
              tags(Conv_integer(unsigned(PC(5 DOWNTO 2)))) <= PC(15 DOWNTO 6);
          END CASE;
          
    END PROCESS;
          
  END ARCHITECTURE Behavior;
  
