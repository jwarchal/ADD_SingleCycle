-- VHDL Entity ADD_SingleCycle_lib.Hookup2.symbol
--
-- Created:
--          by - Vincent.UNKNOWN (VINCENT-LAPTOP)
--          at - 17:19:46 02/16/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Hookup2 IS
   PORT( 
      c   : IN     std_logic;
      rst : IN     std_logic
   );

-- Declarations

END Hookup2 ;

--
-- VHDL Architecture ADD_SingleCycle_lib.Hookup2.struct
--
-- Created:
--          by - Vincent.UNKNOWN (VINCENT-LAPTOP)
--          at - 17:19:46 02/16/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

LIBRARY ADD_SingleCycle_lib;

ARCHITECTURE struct OF Hookup2 IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ALU_L_mux : std_logic_vector(1 DOWNTO 0);
   SIGNAL ALU_R_mux : std_logic_vector(1 DOWNTO 0);
   SIGNAL Mem_en    : std_logic;
   SIGNAL PC_mux    : std_logic;
   SIGNAL RF_en     : std_logic;
   SIGNAL RF_mux    : std_logic;
   SIGNAL SEXT      : std_logic_vector(15 DOWNTO 0);
   SIGNAL ZEXT_L    : std_logic_vector(15 DOWNTO 0);
   SIGNAL ZEXT_R    : std_logic_vector(15 DOWNTO 0);
   SIGNAL b         : std_logic_vector(15 DOWNTO 0);
   SIGNAL b1        : std_logic_vector(15 DOWNTO 0);
   SIGNAL ccvector  : std_logic_vector(3 DOWNTO 0);
   SIGNAL cin       : std_logic;
   SIGNAL dout      : std_logic_vector(4 DOWNTO 0);
   SIGNAL dout1     : std_logic_vector(15 DOWNTO 0);
   SIGNAL dout2     : std_logic;
   SIGNAL dout3     : std_logic;
   SIGNAL hDOut     : std_logic_vector(15 DOWNTO 0);
   SIGNAL hDOut1    : std_logic_vector(15 DOWNTO 0);
   SIGNAL o         : std_logic_vector(15 DOWNTO 0);
   SIGNAL o1        : std_logic_vector(15 DOWNTO 0);
   SIGNAL o2        : std_logic_vector(15 DOWNTO 0);
   SIGNAL o3        : std_logic_vector(15 DOWNTO 0);
   SIGNAL rd0       : std_logic_vector(15 DOWNTO 0);
   SIGNAL rd1       : std_logic_vector(15 DOWNTO 0);
   SIGNAL z         : std_logic_vector(15 DOWNTO 0);


   -- Component Declarations
   COMPONENT ControlUnit
   PORT (
      ConditionCode : IN     std_logic_vector (3 DOWNTO 0);
      InstMem       : IN     std_logic_vector (15 DOWNTO 0);
      clock         : IN     std_logic;
      ALU_L_mux     : OUT    std_logic_vector (1 DOWNTO 0);
      ALU_R_mux     : OUT    std_logic_vector (1 DOWNTO 0);
      Mem_en        : OUT    std_logic;
      PC_mux        : OUT    std_logic;
      RF_en         : OUT    std_logic;
      RF_mux        : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT Extendblock
   PORT (
      inst   : IN     std_logic_vector (15 DOWNTO 0);
      SEXT   : OUT    std_logic_vector (15 DOWNTO 0);
      ZEXT_L : OUT    std_logic_vector (15 DOWNTO 0);
      ZEXT_R : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT Increment
   PORT (
      a : IN     std_logic_vector (15 DOWNTO 0);
      b : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT PC
   PORT (
      a   : IN     std_logic_vector (15 DOWNTO 0);
      c   : IN     std_logic;
      e   : IN     std_logic;
      rst : IN     std_logic;
      b   : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT RegisterFile
   PORT (
      ra0  : IN     std_logic_vector (3 DOWNTO 0);
      ra1  : IN     std_logic_vector (3 DOWNTO 0);
      w_en : IN     std_logic;
      wa   : IN     std_logic_vector (3 DOWNTO 0);
      wd   : IN     std_logic_vector (15 DOWNTO 0);
      rd0  : OUT    std_logic_vector (15 DOWNTO 0);
      rd1  : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT alu
   PORT (
      cin      : IN     std_logic;
      op       : IN     std_logic_vector (4 DOWNTO 0);
      x        : IN     std_logic_vector (15 DOWNTO 0);
      y        : IN     std_logic_vector (15 DOWNTO 0);
      ccvector : OUT    std_logic_vector (3 DOWNTO 0);
      z        : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT easy_RAM_simu
   PORT (
      hAddr : IN     std_logic_vector (15 DOWNTO 0);
      hDIn  : IN     std_logic_vector (15 DOWNTO 0);
      rst   : IN     std_logic;
      wr    : IN     std_logic;
      hDOut : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT mux2to1
   GENERIC (
      size : POSITIVE := 16
   );
   PORT (
      a   : IN     std_logic_vector (size - 1 DOWNTO 0);
      b   : IN     std_logic_vector (size - 1 DOWNTO 0);
      sel : IN     std_logic;
      o   : OUT    std_logic_vector (size - 1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT mux4to1
   GENERIC (
      size : POSITIVE := 16
   );
   PORT (
      a   : IN     std_logic_vector (size - 1 DOWNTO 0);
      b   : IN     std_logic_vector (size - 1 DOWNTO 0);
      c   : IN     std_logic_vector (size - 1 DOWNTO 0);
      d   : IN     std_logic_vector (size - 1 DOWNTO 0);
      sel : IN     std_logic_vector (1 DOWNTO 0);
      o   : OUT    std_logic_vector (size - 1 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : ControlUnit USE ENTITY ADD_SingleCycle_lib.ControlUnit;
   FOR ALL : Extendblock USE ENTITY ADD_SingleCycle_lib.Extendblock;
   FOR ALL : Increment USE ENTITY ADD_SingleCycle_lib.Increment;
   FOR ALL : PC USE ENTITY ADD_SingleCycle_lib.PC;
   FOR ALL : RegisterFile USE ENTITY ADD_SingleCycle_lib.RegisterFile;
   FOR ALL : alu USE ENTITY ADD_SingleCycle_lib.alu;
   FOR ALL : easy_RAM_simu USE ENTITY ADD_SingleCycle_lib.easy_RAM_simu;
   FOR ALL : mux2to1 USE ENTITY ADD_SingleCycle_lib.mux2to1;
   FOR ALL : mux4to1 USE ENTITY ADD_SingleCycle_lib.mux4to1;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.9) for instance 'U_10' of 'constval'
   dout1 <= "0000000000000000";

   -- ModuleWare code(v1.9) for instance 'U_11' of 'constval'
   cin <= '0';

   -- ModuleWare code(v1.9) for instance 'U_14' of 'constval'
   dout2 <= '1';

   -- ModuleWare code(v1.9) for instance 'U_15' of 'constval'
   dout3 <= '0';

   -- ModuleWare code(v1.9) for instance 'U_9' of 'merge'
   dout <= hDOut(14 DOWNTO 13) & hDOut(2 DOWNTO 0);

   -- Instance port mappings.
   U_16 : ControlUnit
      PORT MAP (
         InstMem       => hDOut,
         ConditionCode => ccvector,
         clock         => c,
         ALU_R_mux     => ALU_R_mux,
         ALU_L_mux     => ALU_L_mux,
         PC_mux        => PC_mux,
         RF_mux        => RF_mux,
         Mem_en        => Mem_en,
         RF_en         => RF_en
      );
   U_4 : Extendblock
      PORT MAP (
         inst   => hDOut,
         ZEXT_L => ZEXT_L,
         ZEXT_R => ZEXT_R,
         SEXT   => SEXT
      );
   U_2 : Increment
      PORT MAP (
         a => b1,
         b => b
      );
   U_8 : PC
      PORT MAP (
         a   => o,
         b   => b1,
         c   => c,
         e   => dout2,
         rst => rst
      );
   U_3 : RegisterFile
      PORT MAP (
         w_en => RF_en,
         wd   => o3,
         wa   => hDOut(12 DOWNTO 9),
         ra0  => hDOut(12 DOWNTO 9),
         ra1  => hDOut(8 DOWNTO 5),
         rd0  => rd0,
         rd1  => rd1
      );
   U_5 : alu
      PORT MAP (
         x        => o1,
         y        => o2,
         op       => dout,
         cin      => cin,
         z        => z,
         ccvector => ccvector
      );
   U_1 : easy_RAM_simu
      PORT MAP (
         rst   => rst,
         hDIn  => dout1,
         wr    => dout3,
         hAddr => b1,
         hDOut => hDOut
      );
   U_13 : easy_RAM_simu
      PORT MAP (
         rst   => rst,
         hDIn  => rd0,
         wr    => Mem_en,
         hAddr => z,
         hDOut => hDOut1
      );
   U_0 : mux2to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => b,
         b   => z,
         o   => o,
         sel => PC_mux
      );
   U_12 : mux2to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => z,
         b   => hDOut1,
         o   => o3,
         sel => RF_mux
      );
   U_6 : mux4to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => rd0,
         b   => SEXT,
         c   => ZEXT_R,
         d   => ZEXT_L,
         o   => o2,
         sel => ALU_L_mux
      );
   U_7 : mux4to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => b1,
         b   => dout1,
         c   => rd1,
         d   => rd0,
         o   => o1,
         sel => ALU_R_mux
      );

END struct;