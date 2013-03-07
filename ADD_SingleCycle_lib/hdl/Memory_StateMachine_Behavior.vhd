--
-- VHDL Architecture ADD_SingleCycle_lib.Memory_StateMachine.Behavior
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 10:11:02 03/ 4/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Memory_StateMachine IS
  PORT( clock, ireq, wreq, rreq, ackFromMem : IN std_logic;
        addrFromInst, addrFromData, dataFromMem, dataFromData : IN std_logic_vector(15 DOWNTO 0);
        memw_en, memr_en, ifilled, dfilled : OUT std_logic;
        dataToMem, addrToMem : OUT std_logic_vector(15 DOWNTO 0));
END ENTITY Memory_StateMachine;

--
ARCHITECTURE Behavior OF Memory_StateMachine IS
  TYPE state IS(wfill_state, rfill_state, fill_state, wait_state);
  SIGNAL current_state, next_state: state := wait_state;
  SIGNAL delay : std_logic;
  BEGIN
    
  PROCESS(clock)
      BEGIN
          IF (rising_edge(clock)) THEN
            current_state <= next_state;
          END IF;
  END PROCESS;
  
  PROCESS(wreq, rreq, ireq, ackFromMem)
      BEGIN
        CASE current_state IS
            WHEN wfill_state =>
              IF(ackFromMem = '1') THEN
                next_state <= wait_state;
              ELSE
                next_state <= wfill_state;
              END IF;
            
            WHEN rfill_state =>
              IF (ackFromMem = '1') THEN
                next_state <= wait_state;
              ELSE
                next_state <= rfill_state;
              END IF;
            
            WHEN fill_state =>
              IF (ackFromMem = '1') THEN
                next_state <= wait_state;
              ELSE
                next_State <= fill_state;
              END IF;
              
            WHEN wait_state => --Fix these if statements when we pipeline...
              IF (wreq = '1') THEN
                next_state <= wfill_state;
              ELSIF (rreq = '1') THEN
                next_state <= rfill_state;
              ELSIF (ireq = '1') THEN
                next_state <= fill_state;
              END IF;
              
        END CASE;
  END PROCESS;
  
  PROCESS(current_state)
      BEGIN
        CASE current_state IS
          WHEN wait_state =>
            memw_en <= '0';
            memr_en <= '0';
            ifilled <= '1';
            dfilled <= '1';
            dataToMem <= "0000000000000000";
            addrToMem <= "0000000000000000";
          WHEN wfill_state =>
            memw_en <= '1';
            memr_en <= '0';
            ifilled <= '1';
            dfilled <= '0';
            dataToMem <= dataFromData;
            addrToMem <= addrFromData;
          WHEN rfill_state =>
            memw_en <= '0';
            memr_en <=  '1';
            ifilled <= '1';
            dfilled <= '0';
            dataToMem <= "0000000000000000";
            addrToMem <= addrFromData;
          WHEN fill_state =>
            memw_en <= '0';
            memr_en <= '1';
            ifilled <= '0';
            dfilled <= '1';
            dataToMem <= "0000000000000000";
            addrToMem <= addrFromInst;
        END CASE;
    END PROCESS;
    
END ARCHITECTURE Behavior;
