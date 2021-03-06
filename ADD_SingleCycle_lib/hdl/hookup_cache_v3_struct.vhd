-- VHDL Entity ADD_SingleCycle_lib.Hookup_cache_V3.symbol
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 17:09:24 04/18/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY Hookup_cache_V3 IS
   PORT( 
      c   : IN     std_logic;
      rst : IN     std_logic
   );

-- Declarations

END Hookup_cache_V3 ;

--
-- VHDL Architecture ADD_SingleCycle_lib.Hookup_cache_V3.struct
--
-- Created:
--          by - Rebecca.UNKNOWN (ATHENA)
--          at - 17:09:24 04/18/2013
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2012.1 (Build 6)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

LIBRARY ADD_SingleCycle_lib;

ARCHITECTURE struct OF Hookup_cache_V3 IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ALU_L_mux     : std_logic_vector(1 DOWNTO 0);
   SIGNAL ALU_R_mux     : std_logic_vector(1 DOWNTO 0);
   SIGNAL ALUout        : std_logic_vector(15 DOWNTO 0);
   SIGNAL CCR_en        : std_logic;
   SIGNAL ConditionCode : std_logic_vector(3 DOWNTO 0);
   SIGNAL LEFT          : std_logic_vector(15 DOWNTO 0);
   SIGNAL Mem_en        : std_logic;
   SIGNAL PC_Increment  : std_logic_vector(15 DOWNTO 0);
   SIGNAL PC_en         : std_logic;
   SIGNAL PC_in         : std_logic_vector(15 DOWNTO 0);
   SIGNAL PC_mux        : std_logic_vector(1 DOWNTO 0);
   SIGNAL PC_out        : std_logic_vector(15 DOWNTO 0);
   SIGNAL RF_en         : std_logic;
   SIGNAL RF_mux        : std_logic;
   SIGNAL RIGHT         : std_logic_vector(15 DOWNTO 0);
   SIGNAL SEXT          : std_logic_vector(15 DOWNTO 0);
   SIGNAL ZEXT_L        : std_logic_vector(15 DOWNTO 0);
   SIGNAL ZEXT_R        : std_logic_vector(15 DOWNTO 0);
   SIGNAL ack           : std_logic;
   SIGNAL addr          : std_logic_vector(3 DOWNTO 0);
   SIGNAL addrFromData  : std_logic_vector(15 DOWNTO 0);
   SIGNAL addrFromInst  : std_logic_vector(15 DOWNTO 0);
   SIGNAL addrToMem     : std_logic_vector(15 DOWNTO 0);
   SIGNAL addrToRam     : std_logic_vector(3 DOWNTO 0);
   SIGNAL b             : std_logic_vector(63 DOWNTO 0);
   SIGNAL ccvector      : std_logic_vector(3 DOWNTO 0);
   SIGNAL cin           : std_logic;
   SIGNAL dataFromData  : std_logic_vector(15 DOWNTO 0);
   SIGNAL dataFromMem   : std_logic_vector(63 DOWNTO 0);
   SIGNAL dataToMem     : std_logic_vector(15 DOWNTO 0);
   SIGNAL dataToP       : std_logic_vector(15 DOWNTO 0);
   SIGNAL dataToRam     : std_logic_vector(15 DOWNTO 0);
   SIGNAL dcache_en     : std_logic;
   SIGNAL ddataFromRam  : std_logic_vector(15 DOWNTO 0);
   SIGNAL ddelay        : std_logic;
   SIGNAL dfilled       : std_logic;
   SIGNAL dout          : std_logic_vector(63 DOWNTO 0);
   SIGNAL dout1         : std_logic_vector(5 DOWNTO 0);
   SIGNAL dout2         : std_logic_vector(15 DOWNTO 0);
   SIGNAL idelay        : std_logic;
   SIGNAL ifilled       : std_logic;
   SIGNAL inst          : std_logic_vector(15 DOWNTO 0);
   SIGNAL intwe         : std_logic;
   SIGNAL ireq          : std_logic;
   SIGNAL ramrw_en      : std_logic;
   SIGNAL rd            : std_logic;
   SIGNAL rd0           : std_logic_vector(15 DOWNTO 0);
   SIGNAL rd1           : std_logic_vector(15 DOWNTO 0);
   SIGNAL rreq          : std_logic;
   SIGNAL slicer        : std_logic_vector(1 DOWNTO 0);
   SIGNAL slicer1       : std_logic_vector(1 DOWNTO 0);
   SIGNAL wd            : std_logic_vector(15 DOWNTO 0);
   SIGNAL wr            : std_logic;
   SIGNAL wreq          : std_logic;
   SIGNAL zero          : std_logic_vector(15 DOWNTO 0);


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
   COMPONENT Data_StateMachineV2
   PORT (
      addrFromP   : IN     std_logic_vector (15 DOWNTO 0);
      clock       : IN     std_logic;
      dataFromMem : IN     std_logic_vector (63 DOWNTO 0);
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
      slicer      : OUT    std_logic_vector (1 DOWNTO 0);
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
   COMPONENT Inst_StateMachine_V3
   PORT (
      PC          : IN     std_logic_vector (15 DOWNTO 0);
      clock       : IN     std_logic;
      ifilled     : IN     std_logic;
      instFromMem : IN     std_logic_vector (63 DOWNTO 0);
      instFromRAM : IN     std_logic_vector (15 DOWNTO 0);
      MMdataToRAM : OUT    std_logic_vector (63 DOWNTO 0);
      addr        : OUT    std_logic_vector (3 DOWNTO 0);
      addrToMem   : OUT    std_logic_vector (15 DOWNTO 0);
      idelay      : OUT    std_logic;
      inst        : OUT    std_logic_vector (15 DOWNTO 0);
      intwe       : OUT    std_logic;
      ireq        : OUT    std_logic;
      slicer      : OUT    std_logic_vector (1 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT Memory_StateMachine_V2
   PORT (
      ackFromMem   : IN     std_logic;
      addrFromData : IN     std_logic_vector (15 DOWNTO 0);
      addrFromInst : IN     std_logic_vector (15 DOWNTO 0);
      clock        : IN     std_logic;
      dataFromData : IN     std_logic_vector (15 DOWNTO 0);
      dataFromMem  : IN     std_logic_vector (63 DOWNTO 0);
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
   COMPONENT Reg
   PORT (
      a : IN     std_logic_vector (63 DOWNTO 0);
      c : IN     std_logic;
      b : OUT    std_logic_vector (63 DOWNTO 0)
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
   COMPONENT cachedata_lols_v3
   PORT (
      addr : IN     std_logic_vector (3 DOWNTO 0);
      clk  : IN     std_logic;
      din  : IN     std_logic_vector (63 DOWNTO 0);
      we   : IN     std_logic;
      dout : OUT    std_logic_vector (63 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT datacache_V2
   PORT (
      addr   : IN     std_logic_vector (3 DOWNTO 0);
      clk    : IN     std_logic;
      din    : IN     std_logic_vector (15 DOWNTO 0);
      slicer : IN     std_logic_vector (1 DOWNTO 0);
      we     : IN     std_logic;
      dout   : OUT    std_logic_vector (15 DOWNTO 0)
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
   COMPONENT ram_delay_v3
   PORT (
      hAddr : IN     std_logic_vector (15 DOWNTO 0);
      hDIn  : IN     std_logic_vector (15 DOWNTO 0);
      rd    : IN     std_logic;
      rst   : IN     std_logic;
      wr    : IN     std_logic;
      ack   : OUT    std_logic;
      hDOut : OUT    std_logic_vector (63 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   FOR ALL : CCReg USE ENTITY ADD_SingleCycle_lib.CCReg;
   FOR ALL : ControlUnit USE ENTITY ADD_SingleCycle_lib.ControlUnit;
   FOR ALL : Data_StateMachineV2 USE ENTITY ADD_SingleCycle_lib.Data_StateMachineV2;
   FOR ALL : Extendblock USE ENTITY ADD_SingleCycle_lib.Extendblock;
   FOR ALL : Increment USE ENTITY ADD_SingleCycle_lib.Increment;
   FOR ALL : Inst_StateMachine_V3 USE ENTITY ADD_SingleCycle_lib.Inst_StateMachine_V3;
   FOR ALL : Memory_StateMachine_V2 USE ENTITY ADD_SingleCycle_lib.Memory_StateMachine_V2;
   FOR ALL : PC USE ENTITY ADD_SingleCycle_lib.PC;
   FOR ALL : Reg USE ENTITY ADD_SingleCycle_lib.Reg;
   FOR ALL : RegisterFile USE ENTITY ADD_SingleCycle_lib.RegisterFile;
   FOR ALL : alu USE ENTITY ADD_SingleCycle_lib.alu;
   FOR ALL : cachedata_lols_v3 USE ENTITY ADD_SingleCycle_lib.cachedata_lols_v3;
   FOR ALL : datacache_V2 USE ENTITY ADD_SingleCycle_lib.datacache_V2;
   FOR ALL : mux2to1 USE ENTITY ADD_SingleCycle_lib.mux2to1;
   FOR ALL : mux4to1 USE ENTITY ADD_SingleCycle_lib.mux4to1;
   FOR ALL : ram_delay_v3 USE ENTITY ADD_SingleCycle_lib.ram_delay_v3;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.9) for instance 'U_12' of 'constval'
   zero <= "0000000000000000";

   -- ModuleWare code(v1.9) for instance 'U_14' of 'constval'
   cin <= '0';

   -- ModuleWare code(v1.9) for instance 'U_16' of 'constval'
   CCR_en <= '1';

   -- ModuleWare code(v1.9) for instance 'U_19' of 'constval'
   PC_en <= '1';

   -- ModuleWare code(v1.9) for instance 'U_6' of 'merge'
   dout1 <= inst(15 DOWNTO 13) & inst(2 DOWNTO 0);

   -- ModuleWare code(v1.9) for instance 'U_21' of 'mux'
   u_21combo_proc: PROCESS(dout, slicer)
   BEGIN
      CASE slicer IS
      WHEN "00" => dout2 <= dout(15 DOWNTO 0);
      WHEN "01" => dout2 <= dout(31 DOWNTO 16);
      WHEN "10" => dout2 <= dout(47 DOWNTO 32);
      WHEN "11" => dout2 <= dout(63 DOWNTO 48);
      WHEN OTHERS => dout2 <= (OTHERS => 'X');
      END CASE;
   END PROCESS u_21combo_proc;

   -- Instance port mappings.
   U_15 : CCReg
      PORT MAP (
         a   => ccvector,
         b   => ConditionCode,
         c   => c,
         e   => CCR_en,
         rst => rst
      );
   U_7 : ControlUnit
      PORT MAP (
         InstMem       => inst,
         idelay        => idelay,
         ddelay        => ddelay,
         ConditionCode => ConditionCode,
         PC_mux        => PC_mux,
         ALU_R_mux     => ALU_R_mux,
         ALU_L_mux     => ALU_L_mux,
         RF_mux        => RF_mux,
         Mem_en        => Mem_en,
         RF_en         => RF_en,
         dcache_en     => dcache_en
      );
   U_17 : Data_StateMachineV2
      PORT MAP (
         clock       => c,
         dfilled     => dfilled,
         rw_en       => Mem_en,
         dcache_en   => dcache_en,
         addrFromP   => ALUout,
         dataFromP   => rd0,
         dataFromRam => ddataFromRam,
         dataFromMem => dataFromMem,
         dataToP     => dataToP,
         addrToMem   => addrFromData,
         dataToMem   => dataFromData,
         dataToRam   => dataToRam,
         addrToRam   => addrToRam,
         ddelay      => ddelay,
         rreq        => rreq,
         wreq        => wreq,
         ramrw_en    => ramrw_en,
         slicer      => slicer1
      );
   U_9 : Extendblock
      PORT MAP (
         inst   => inst,
         ZEXT_L => ZEXT_L,
         ZEXT_R => ZEXT_R,
         SEXT   => SEXT
      );
   U_2 : Increment
      PORT MAP (
         a => PC_out,
         b => PC_Increment
      );
   U_3 : Inst_StateMachine_V3
      PORT MAP (
         clock       => c,
         ifilled     => ifilled,
         PC          => PC_in,
         instFromRAM => dout2,
         instFromMem => dataFromMem,
         addrToMem   => addrFromInst,
         inst        => inst,
         MMdataToRAM => OPEN,
         addr        => addr,
         idelay      => idelay,
         ireq        => ireq,
         intwe       => intwe,
         slicer      => slicer
      );
   U_22 : Memory_StateMachine_V2
      PORT MAP (
         clock        => c,
         ireq         => ireq,
         wreq         => wreq,
         rreq         => rreq,
         ackFromMem   => ack,
         addrFromInst => addrFromInst,
         addrFromData => addrFromData,
         dataFromData => dataFromData,
         dataFromMem  => dataFromMem,
         memw_en      => wr,
         memr_en      => rd,
         ifilled      => ifilled,
         dfilled      => dfilled,
         addrToMem    => dataToMem,
         dataToMem    => addrToMem
      );
   U_1 : PC
      PORT MAP (
         a   => PC_in,
         b   => PC_out,
         c   => c,
         e   => PC_en,
         rst => rst
      );
   U_23 : Reg
      PORT MAP (
         a => dataFromMem,
         c => c,
         b => b
      );
   U_5 : RegisterFile
      PORT MAP (
         clock => c,
         w_en  => RF_en,
         wd    => wd,
         wa    => inst(12 DOWNTO 9),
         ra0   => inst(12 DOWNTO 9),
         ra1   => inst(8 DOWNTO 5),
         rd0   => rd0,
         rd1   => rd1
      );
   U_13 : alu
      PORT MAP (
         x        => RIGHT,
         y        => LEFT,
         op       => dout1,
         cin      => cin,
         z        => ALUout,
         ccvector => ccvector
      );
   U_4 : cachedata_lols_v3
      PORT MAP (
         clk  => c,
         din  => b,
         addr => addr,
         we   => intwe,
         dout => dout
      );
   U_18 : datacache_V2
      PORT MAP (
         slicer => slicer1,
         addr   => addrToRam,
         clk    => c,
         din    => dataToRam,
         we     => ramrw_en,
         dout   => ddataFromRam
      );
   U_8 : mux2to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => ALUout,
         b   => dataToP,
         o   => wd,
         sel => RF_mux
      );
   U_0 : mux4to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => PC_Increment,
         b   => ALUout,
         c   => PC_out,
         d   => PC_out,
         o   => PC_in,
         sel => PC_mux
      );
   U_10 : mux4to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => rd0,
         b   => SEXT,
         c   => ZEXT_R,
         d   => ZEXT_L,
         o   => LEFT,
         sel => ALU_L_mux
      );
   U_11 : mux4to1
      GENERIC MAP (
         size => 16
      )
      PORT MAP (
         a   => PC_out,
         b   => zero,
         c   => rd1,
         d   => rd0,
         o   => RIGHT,
         sel => ALU_R_mux
      );
   U_20 : ram_delay_v3
      PORT MAP (
         rst   => rst,
         hDIn  => dataToMem,
         wr    => wr,
         rd    => rd,
         ack   => ack,
         hAddr => addrToMem,
         hDOut => dataFromMem
      );

END struct;
