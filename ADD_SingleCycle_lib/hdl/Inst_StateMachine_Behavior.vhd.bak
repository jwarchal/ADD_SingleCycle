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
    PORT ( clock, ifilled: IN std_logic;
           addr, idata, intrdata: IN std_logic_vector (15 DOWNTO 0);
           inst, iaddr, intwdata: OUT std_logic_vector (15 DOWNTO 0);
           intaddr: OUT std_logic_vector (3 DOWNTO 0);
           idelay, ireq, intwe: OUT std_logic );
  END ENTITY Inst_StateMachine;
  
  --
  ARCHITECTURE Behavior OF Inst_StateMachine IS
    TYPE state IS(hit_state, wait_state);
    TYPE tagarray IS ARRAY (0 TO 15) OF std_logic_vector(11 DOWNTO 0);
    SIGNAL current_state, next_state: state;
    SIGNAL tags: tagarray :=("000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000","000000000000");
    BEGIN
    PROCESS(clock)
      BEGIN
          IF (rising_edge(clock)) THEN
            current_state <= next_state;
          END IF;
    END PROCESS;
  
    PROCESS(addr, ifilled)
    VARIABLE hit: std_logic := '0';
      BEGIN
        hit := '0';
        FOR i IN 0 TO 15 LOOP
          IF(tags(i) = addr(15 DOWNTO 4)) THEN
            hit := '1';
          END IF;
        END LOOP;
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
  
    PROCESS(current_state)
      BEGIN
        CASE current_state IS
          WHEN hit_state =>
            iaddr <= addr;
            idelay <= '0';
            ireq <= '0';
            intwe <= '0';
            intaddr <= addr(3 DOWNTO 0);
            inst <= intrdata;
            intwdata <= "0000000000000000";
          WHEN wait_state =>
            iaddr <= addr;
            idelay <= '1';
            ireq <= '1';
            intwe <= '1';
            intaddr <= addr(3 DOWNTO 0);
            inst <= intrdata;
            intwdata <= idata;
            tagarray(to_integer(unsigned(addr(3 DOWNTO 0)))) <= addr(15 DOWNTO 4);
        END CASE;
    END PROCESS;
          
  END ARCHITECTURE Behavior;
  
