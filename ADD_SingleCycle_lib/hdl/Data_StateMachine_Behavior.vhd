--
-- VHDL Architecture ADD_SingleCycle_lib.Data_StateMachine.Behavior
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 12:06:47 03/ 1/2013
--
-- using Mentor Graphics HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Data_StateMachine IS
  PORT ( clock, dfilled, rw_en, dcache_en : IN std_logic;
         addrFromP, dataFromP, dataFromMem, dataFromRam: IN std_logic_vector(15 DOWNTO 0);
         dataToP, addrToMem, dataToMem, dataToRam: OUT std_logic_vector (15 DOWNTO 0);
         addrToRam: OUT std_logic_vector (3 DOWNTO 0);
         ddelay, rreq, wreq, ramrw_en : OUT std_logic);
END ENTITY Data_StateMachine;

--
ARCHITECTURE Behavior OF Data_StateMachine IS
   TYPE state IS(hit_state, rreq_state, wreq_state, rlimbo_state, wlimbo_state);
   TYPE tagarray IS ARRAY (0 TO 15) OF std_logic_vector(11 DOWNTO 0);
   SIGNAL current_state, next_state: state := hit_state;
   SIGNAL tags: tagarray; 
   BEGIN
    PROCESS(clock)
      BEGIN
          IF (rising_edge(clock)) THEN
            current_state <= next_state;
          END IF;
    END PROCESS;
    
    PROCESS(addrFromP, dfilled)
     VARIABLE hit: std_logic := '0';
      BEGIN
        hit := '0';
        FOR i IN 0 TO 15 LOOP
          IF(tags(i) = addrFromP(15 DOWNTO 4)) THEN
            hit := '1';
          END IF;
        END LOOP;
        
        CASE current_state IS
          
            WHEN hit_state =>
            IF (dcache_en = '1') THEN
              IF(hit = '1') THEN
                next_state <= hit_state;
              ELSE
                IF(rw_en = '0') THEN
                  next_state <= rlimbo_state;
                ELSE
                  next_state <= wlimbo_state;
                END IF;
              END IF;
            ELSE
              next_state <= hit_state;
            END IF;
            
            WHEN rreq_state =>
              IF(dfilled = '0') THEN
                next_state <= rreq_state;
              ELSE
                next_state <= hit_state;
              END IF;
            
            WHEN wreq_state =>
              IF(dfilled= '0') THEN
                next_state <= wreq_state;
              ELSE
                next_state <= hit_state;
              END IF;
              
            WHEN rlimbo_state =>
              next_state <= rreq_state;
            WHEN wlimbo_state =>
              next_state <= wreq_state;
        END CASE;
    END PROCESS;
    
    PROCESS(current_state)
      BEGIN
  
          CASE current_state IS
            WHEN hit_state =>
              addrToMem <= addrFromP;
              ddelay <= '0';
              rreq <= '0';
              wreq <= '0';
              ramrw_en <= '0';
              addrToRam <= addrFromP(3 DOWNTO 0);
              dataToP <= dataFromRam;
              dataToRam <= "0000000000000000";
            WHEN rreq_state =>
              addrToMem <= addrFromP;
              ddelay <= '1';
              rreq <= '1';
              wreq <= '0';
              ramrw_en <= '1';  --1=write, write Mem data into ram
              addrToRam <= addrFromP(3 DOWNTO 0);
              dataToRam <= dataFromMem;
              dataToP <= dataFromMem;
              tags(Conv_integer(unsigned(addrFromP(3 DOWNTO 0)))) <= addrFromP(15 DOWNTO 4);
            WHEN wreq_state =>
              addrToMem <= addrFromP;
              ddelay <= '1';
              rreq <= '0';
              wreq <= '1';
              ramrw_en <= '1';  --1=write, write Mem data into ram
              addrToRam <= addrFromP(3 DOWNTO 0);
              dataToRam <= dataFromP;
              dataToMem <= dataFromP;
              tags(Conv_integer(unsigned(addrFromP(3 DOWNTO 0)))) <= addrFromP(15 DOWNTO 4);
            WHEN rlimbo_state =>
              addrToMem <= addrFromP;
              ddelay <= '1';
              rreq <= '1';
              wreq <= '0';
              ramrw_en <= '1';  --1=write, write Mem data into ram
              addrToRam <= addrFromP(3 DOWNTO 0);
              dataToRam <= dataFromMem;
              dataToP <= dataFromMem;
              tags(Conv_integer(unsigned(addrFromP(3 DOWNTO 0)))) <= addrFromP(15 DOWNTO 4);
            WHEN wlimbo_state =>
              addrToMem <= addrFromP;
              ddelay <= '1';
              rreq <= '0';
              wreq <= '1';
              ramrw_en <= '1';  --1=write, write Mem data into ram
              addrToRam <= addrFromP(3 DOWNTO 0);
              dataToRam <= dataFromP;
              dataToMem <= dataFromP;
              tags(Conv_integer(unsigned(addrFromP(3 DOWNTO 0)))) <= addrFromP(15 DOWNTO 4);
        END CASE;
      
        
    END PROCESS;
    

END ARCHITECTURE Behavior;
