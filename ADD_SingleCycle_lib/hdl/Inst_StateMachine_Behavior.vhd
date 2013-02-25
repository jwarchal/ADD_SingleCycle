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
  
  ENTITY Inst_StateMachine IS
    PORT ( clock, ifilled, fit: IN std_logic;
           addr, data : IN std_logic_vector (15 DOWNTO 0);
           inst, iaddr: OUT std_logic_vector (15 DOWNTO 0);
           idelay, irequest : OUT std_logic );
  END ENTITY Inst_StateMachine;
  
  --
  ARCHITECTURE Behavior OF Inst_StateMachine IS
    TYPE state IS(hit_state, wait_state);
    SIGNAL current_state, next_state: state;
  
    BEGIN
    PROCESS(clock)
      BEGIN
          IF (rising_edge(clock)) THEN
            current_state <= next_state;
          END IF;
    END PROCESS;
  
    PROCESS(hit, addr, data, ifilled)
      BEGIN
        CASE current_state IS
            WHEN hit_state =>
            IF(hit = '1') THEN
              next_state <= hit_state;
            ELSE
              next_state <= wait_state;
            END IF;
  
            WHEN wait_state =>
            IF(ifilled = '0') THEN
              next_state <= wait_state;
            ELSE
              next_state <= hit_state;
            END IF;
        END CASE;
    END PROCESS;
  
    PROCESS(hit_state, wait_state)
      BEGIN
        --CASE current_state IS
          
        --END CASE;
    END PROCESS;
          
  END ARCHITECTURE Behavior;
  
