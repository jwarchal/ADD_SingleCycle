-- VHDL Entity ADD_SingleCycle_lib.Hookup3.symbol
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 21:41:03 03/ 4/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Hookup3 IS
   PORT( 
      c   : IN     std_logic;
      rst : IN     std_logic
   );

-- Declarations

END Hookup3 ;

--
-- VHDL Architecture ADD_SingleCycle_lib.Hookup3.struct
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 21:41:03 03/ 4/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;
USE ieee.numeric_std.all;
USE ieee.math_real.all;

LIBRARY ADD_SingleCycle_lib;

ARCHITECTURE struct OF Hookup3 IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ALU_L_mux  : std_logic_vector(1 DOWNTO 0);
   SIGNAL ALU_R_mux  : std_logic_vector(1 DOWNTO 0);
   SIGNAL Mem_en     : std_logic;
   SIGNAL PC_mux1    : std_logic_vector(1 DOWNTO 0);
   SIGNAL RF_en      : std_logic;
   SIGNAL RF_mux     : std_logic;
   SIGNAL SEXT       : std_logic_vector(15 DOWNTO 0);
   SIGNAL ZEXT_L     : std_logic_vector(15 DOWNTO 0);
   SIGNAL ZEXT_R     : std_logic_vector(15 DOWNTO 0);
   SIGNAL ack        : std_logic;
   SIGNAL addrToMem  : std_logic_vector(15 DOWNTO 0);
   SIGNAL addrToMem1 : std_logic_vector(15 DOWNTO 0);
   SIGNAL addrToRam  : std_logic_vector(3 DOWNTO 0);
   SIGNAL b          : std_logic_vector(15 DOWNTO 0);
   SIGNAL b1         : std_logic_vector(15 DOWNTO 0);
   SIGNAL b2         : std_logic_vector(3 DOWNTO 0);
   SIGNAL ccvector   : std_logic_vector(3 DOWNTO 0);
   SIGNAL cin        : std_logic;
   SIGNAL dataToMem  : std_logic_vector(15 DOWNTO 0);
   SIGNAL dataToMem1 : std_logic_vector(15 DOWNTO 0);
   SIGNAL dataToRam  : std_logic_vector(15 DOWNTO 0);
   SIGNAL dcache_en  : std_logic;
   SIGNAL ddelay     : std_logic;
   SIGNAL dfilled    : std_logic;
   SIGNAL dout       : std_logic_vector(5 DOWNTO 0);
   SIGNAL dout1      : std_logic_vector(15 DOWNTO 0);
   SIGNAL dout2      : std_logic;
   SIGNAL dout3      : std_logic;
   SIGNAL dout4      : std_logic_vector(15 DOWNTO 0);
   SIGNAL dout5      : std_logic_vector(15 DOWNTO 0);
   SIGNAL hDOut      : std_logic_vector(15 DOWNTO 0);
   SIGNAL hDOut1     : std_logic_vector(15 DOWNTO 0);
   SIGNAL hDOut2     : std_logic_vector(15 DOWNTO 0);
   SIGNAL iaddr      : std_logic_vector(15 DOWNTO 0);
   SIGNAL idelay     : std_logic;
   SIGNAL ifilled    : std_logic;
   SIGNAL intaddr    : std_logic_vector(3 DOWNTO 0);
   SIGNAL intwdata   : std_logic_vector(15 DOWNTO 0);
   SIGNAL intwe      : std_logic;
   SIGNAL ireq       : std_logic;
   SIGNAL memr_en    : std_logic;
   SIGNAL memw_en    : std_logic;
   SIGNAL o          : std_logic_vector(15 DOWNTO 0);
   SIGNAL o1         : std_logic_vector(15 DOWNTO 0);
   SIGNAL o2         : std_logic_vector(15 DOWNTO 0);
   SIGNAL o3         : std_logic_vector(15 DOWNTO 0);
   SIGNAL ramrw_en   : std_logic;
   SIGNAL rd0        : std_logic_vector(15 DOWNTO 0);
   SIGNAL rd1        : std_logic_vector(15 DOWNTO 0);
   SIGNAL rreq       : std_logic;
   SIGNAL wreq       : std_logic;
   SIGNAL z          : std_logic_vector(15 DOWNTO 0);


   -- Component Declarations
   COMPONENT CCReg
   PORT (
      a   : IN     std_logic_vector (3 DOWNTO 0);
      c   : IN     std_logic;
      e   : IN     std_logic;
      rst : IN     std_logic;
      b   : OUT    std_logic_vector (3 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT ControlUnit
   PORT (
      ConditionCode : IN     std_logic_vector (3 DOWNTO 0);
      InstMem       : IN     std_logic_vector (15 DOWNTO 0);
      ddelay        : IN     std_logic;
      idelay        : IN     std_logic;
      ALU_L_mux     : OUT    std_logic_vector (1 DOWNTO 0);
      ALU_R_mux     : OUT    std_logic_vector (1 DOWNTO 0);
      Mem_en        : OUT    std_logic;
      PC_mux        : OUT    std_logic_vector (1 DOWNTO 0);
      RF_en         : OUT    std_logic;
      RF_mux        : OUT    std_logic;
      dcache_en     : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT Data_StateMachine
   PORT (
      addrFromP   : IN     std_logic_vector (15 DOWNTO 0);
      clock       : IN     std_logic;
      dataFromMem : IN     std_logic_vector (15 DOWNTO 0);
      dataFromP   : IN     std_logic_vector (15 DOWNTO 0);
      dataFromRam : IN     std_logic_vector (15 DOWNTO 0);
      dcache_en   : IN     std_logic;
      dfilled     : IN     std_logic;
      rw_en       : IN     std_logic;
      addrToMem   : OUT    std_logic_vector (15 DOWNTO 0);
      addrToRam   : OUT    std_logic_vector (3 DOWNTO 0);
      dataToMem   : OUT    std_logic_vector (15 DOWNTO 0);
      dataToP     : OUT    std_logic_vector (15 DOWNTO 0);
      dataToRam   : OUT    std_logic_vector (15 DOWNTO 0);
      ddelay      : OUT    std_logic;
      ramrw_en    : OUT    std_logic;
      rreq        : OUT    std_logic;
      wreq        : OUT    std_logic
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
   COMPONENT Inst_StateMachine
   PORT (
      addr     : IN     std_logic_vector (15 DOWNTO 0);
      clock    : IN     std_logic;
      idata    : IN     std_logic_vector (15 DOWNTO 0);
      ifilled  : IN     std_logic;
      intrdata : IN     std_logic_vector (15 DOWNTO 0);
      iaddr    : OUT    std_logic_vector (15 DOWNTO 0);
      idelay   : OUT    std_logic;
      inst     : OUT    std_logic_vector (15 DOWNTO 0);
      intaddr  : OUT    std_logic_vector (3 DOWNTO 0);
      intwdata : OUT    std_logic_vector (15 DOWNTO 0);
      intwe    : OUT    std_logic;
      ireq     : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT Memory_StateMachine
   PORT (
      ackFromMem   : IN     std_logic;
      addrFromData : IN     std_logic_vector (15 DOWNTO 0);
      addrFromInst : IN     std_logic_vector (15 DOWNTO 0);
      clock        : IN     std_logic;
      dataFromData : IN     std_logic_vector (15 DOWNTO 0);
      dataFromMem  : IN     std_logic_vector (15 DOWNTO 0);
      ireq         : IN     std_logic;
      rreq         : IN     std_logic;
      wreq         : IN     std_logic;
      addrToMem    : OUT    std_logic_vector (15 DOWNTO 0);
      dataToMem    : OUT    std_logic_vector (15 DOWNTO 0);
      dfilled      : OUT    std_logic;
      ifilled      : OUT    std_logic;
      memr_en      : OUT    std_logic;
      memw_en      : OUT    std_logic
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
      clock : IN     std_logic;
      ra0   : IN     std_logic_vector (3 DOWNTO 0);
      ra1   : IN     std_logic_vector (3 DOWNTO 0);
      w_en  : IN     std_logic;
      wa    : IN     std_logic_vector (3 DOWNTO 0);
      wd    : IN     std_logic_vector (15 DOWNTO 0);
      rd0   : OUT    std_logic_vector (15 DOWNTO 0);
      rd1   : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT alu
   PORT (
      cin      : IN     std_logic;
      op       : IN     std_logic_vector (5 DOWNTO 0);
      x        : IN     std_logic_vector (15 DOWNTO 0);
      y        : IN     std_logic_vector (15 DOWNTO 0);
      ccvector : OUT    std_logic_vector (3 DOWNTO 0);
      z        : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT cachedata
   PORT (
      addr : IN     std_logic_vector (3 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (15 DOWNTO 0);
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (15 DOWNTO 0)
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
   COMPONENT ram_delay
   PORT (
      hAddr : IN     std_logic_vector (15 DOWNTO 0);
      hDIn  : IN     std_logic_vector (15 DOWNTO 0);
      rd    : IN     std_logic;
      rst   : IN     std_logic;
      wr    : IN     std_logic;
      ack   : OUT    std_logic;
      hDOut : OUT    std_logic_vector (15 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : CCReg USE ENTITY ADD_SingleCycle_lib.CCReg;
   FOR ALL : ControlUnit USE ENTITY ADD_SingleCycle_lib.ControlUnit;
   FOR ALL : Data_StateMachine USE ENTITY ADD_SingleCycle_lib.Data_StateMachine;
   FOR ALL : Extendblock USE ENTITY ADD_SingleCycle_lib.Extendblock;
   FOR ALL : Increment USE ENTITY ADD_SingleCycle_lib.Increment;
   FOR ALL : Inst_StateMachine USE ENTITY ADD_SingleCycle_lib.Inst_StateMachine;
   FOR ALL : Memory_StateMachine USE ENTITY ADD_SingleCycle_lib.Memory_StateMachine;
   FOR ALL : PC USE ENTITY ADD_SingleCycle_lib.PC;
   FOR ALL : RegisterFile USE ENTITY ADD_SingleCycle_lib.RegisterFile;
   FOR ALL : alu USE ENTITY ADD_SingleCycle_lib.alu;
   FOR ALL : cachedata USE ENTITY ADD_SingleCycle_lib.cachedata;
   FOR ALL : mux2to1 USE ENTITY ADD_SingleCycle_lib.mux2to1;
   FOR ALL : mux4to1 USE ENTITY ADD_SingleCycle_lib.mux4to1;
   FOR ALL : ram_delay USE ENTITY ADD_SingleCycle_lib.ram_delay;
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
   dout <= hDOut(15 DOWNTO 13) & hDOut(2 DOWNTO 0);

   -- Instance port mappings.
   U_17 : CCReg
      PORT MAP (
         a   => ccvector,
         b   => b2,
         c   => c,
         e   => dout2,
         rst => rst
      );
   U_16 : ControlUnit
      PORT MAP (
         InstMem       => hDOut,
         idelay        => idelay,
         ddelay        => ddelay,
         ConditionCode => b2,
         PC_mux        => PC_mux1,
         ALU_R_mux     => ALU_R_mux,
         ALU_L_mux     => ALU_L_mux,
         RF_mux        => RF_mux,
         Mem_en        => Mem_en,
         RF_en         => RF_en,
         dcache_en     => dcache_en
      );
   U_19 : Data_StateMachine
      PORT MAP (
         clock       => c,
         dfilled     => dfilled,
         rw_en       => Mem_en,
         dcache_en   => dcache_en,
         addrFromP   => z,
         dataFromP   => rd0,
         dataFromMem => hDOut2,
         dataFromRam => dout5,
         dataToP     => hDOut1,
         addrToMem   => addrToMem1,
         dataToMem   => dataToMem1,
         dataToRam   => dataToRam,
         addrToRam   => addrToRam,
         ddelay      => ddelay,
         rreq        => rreq,
         wreq        => wreq,
         ramrw_en    => ramrw_en
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
   U_1 : Inst_StateMachine
      PORT MAP (
         clock    => c,
         ifilled  => ifilled,
         addr     => b1,
         idata    => dout1,
         intrdata => dout4,
         inst     => hDOut,
         iaddr    => iaddr,
         intwdata => intwdata,
         intaddr  => intaddr,
         idelay   => idelay,
         ireq     => ireq,
         intwe    => intwe
      );
   U_21 : Memory_StateMachine
      PORT MAP (
         clock        => c,
         ireq         => ireq,
         wreq         => wreq,
         rreq         => rreq,
         ackFromMem   => ack,
         addrFromInst => iaddr,
         addrFromData => addrToMem1,
         dataFromMem  => hDOut2,
         dataFromData => dataToMem1,
         memw_en      => memw_en,
         memr_en      => memr_en,
         ifilled      => ifilled,
         dfilled      => dfilled,
         dataToMem    => dataToMem,
         addrToMem    => addrToMem
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
         clock => c,
         w_en  => RF_en,
         wd    => o3,
         wa    => hDOut(12 DOWNTO 9),
         ra0   => hDOut(12 DOWNTO 9),
         ra1   => hDOut(8 DOWNTO 5),
         rd0   => rd0,
         rd1   => rd1
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
   U_13 : cachedata
      PORT MAP (
         addr => intaddr,
         clk  => c,
         din  => intwdata,
         we   => intwe,
         dout => dout4
      );
   U_22 : cachedata
      PORT MAP (
         addr => addrToRam,
         clk  => c,
         din  => dataToRam,
         we   => ramrw_en,
         dout => dout5
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
   U_0 : mux4to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => b,
         b   => z,
         c   => b1,
         d   => b1,
         o   => o,
         sel => PC_mux1
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
   U_20 : ram_delay
      PORT MAP (
         rst   => rst,
         hDIn  => dataToMem,
         wr    => memw_en,
         rd    => memr_en,
         ack   => ack,
         hAddr => addrToMem,
         hDOut => hDOut2
      );

END struct;