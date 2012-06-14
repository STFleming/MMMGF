library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

 library work;                           --XST
 use work.standby_pkg.all;               --XST

 ENTITY STANDBY IS
   GENERIC (
      COMPNAME                : string
   );
       PORT  (
                CLK0              : OUT std_logic ; 
                CLK180            : OUT std_logic ;
                CLK270            : OUT std_logic ;
                CLK2X             : OUT std_logic ;
                CLK2X180          : OUT std_logic ;
                CLK90             : OUT std_logic ;
                CLKDV             : OUT std_logic ;
                CLKFX             : OUT std_logic ;
                CLKFX180          : OUT std_logic ;
                LOCKED            : OUT std_logic ;
                DO                : OUT std_logic_vector(15 DOWNTO 0);
                PSDONE            : OUT std_logic ;
                CLKFB             : IN  std_logic ;
                CLKIN             : IN  std_logic ;
                PSCLK             : IN  std_logic ; 
                PSEN              : IN  std_logic ;
                PSINCDEC          : IN  std_logic ; 
                S0                : OUT std_logic ;
                S1                : OUT std_logic ;
                I1                : OUT std_logic ;
                CLK               : IN  std_logic ; 
                RST               : IN  std_logic 
                );
   END STANDBY ;



ARCHITECTURE STANDBY OF STANDBY IS

  ------------------USER EDITABLE CONSTANTS---------------------------------------
  constant  USE_FX_SYNCLK             : boolean       := FALSE ;
  constant  TIMEOUT_SCALE             : integer       := 6 ;


  -- The following constants are used in RTL simulation only
--  constant   CONST_DLL_FREQUENCY_MODE : string := "HIGH" ;
--  constant   CONST_DFS_FREQUENCY_MODE : string := "HIGH" ;
  constant   CONST_DLL_FREQUENCY_MODE : string := "LOW" ;
  constant   CONST_DFS_FREQUENCY_MODE : string := "LOW" ;
  constant   CONST_CLK_FEEDBACK       : string := "1X" ;
  constant   CONST_CLKOUT_PHASE_SHIFT : string := "NONE" ;
  constant   CONST_PHASE_SHIFT        : integer := 0 ;
  constant   CONST_CLKDV_DIVIDE       : real    := 2.0  ;
  constant   CONST_CLKFX_MULTIPLY     : integer := 4 ;  -- default value
  constant   CONST_CLKFX_DIVIDE       : integer := 1 ;  -- default value
  constant   CONST_CLKIN_DIVIDE_BY_2  : boolean := FALSE;
  constant   CONST_DCM_AUTOCALIBRATION  : boolean := FALSE;
  constant   CONST_DESKEW_ADJUST      : string  := "SYSTEM_SYNCHRONOUS";
  constant   CONST_FACTORY_JF         : bit_vector  :=  X"F0F0";

----------------------------------------------------------------------------------
-- State machine encoding 
--  Do not change these parameters.
--  Do not change encoding.
--  State bits are used as outputs.
--  DCM_STATE[0] indicates EXERCISE state.
--  DCM_STATE[1] indicates RESTORE state.
--  DCM_STATE[2] indicates allow outputs.
--
-- parameter SAVE      = 3'b000;
-- parameter EXERCISE  = 3'b001;
-- parameter RESTORE   = 3'b010;
-- parameter RUN       = 3'b100;
-----------------------------------------------------------------------------------

-- type  states is  (SAVE, EXERCISE, RESTORE, RUN);
-- attribute ENUM_ENCODING of states : type is " 000 001 010 100" ;


subtype states is std_logic_vector(2 downto 0);
CONSTANT SAVE : states := "000" ;
CONSTANT EXERCISE : states := "001" ;
CONSTANT RESTORE  : states := "010" ;
CONSTANT RUN      : states := "100" ;
 
 signal DCM_STATE : states  := SAVE;

  ATTRIBUTE FSM_ENCODING : string;
  ATTRIBUTE FSM_ENCODING OF DCM_STATE : SIGNAL IS "USER";

  ------------------------------------------------------------------------------
  -- Signal Declaration
  ------------------------------------------------------------------------------


  signal    FACLK                    :  std_logic ;
  signal    CLKIN_BUFGED             :  std_logic ;
  signal    ACTIVE                   :  std_logic ;
  signal    FACLKSTOP                :  std_logic ;
  signal    RUN_FLAG                 :  std_logic := '0';
  signal    RUN_TEMP                 :  std_logic;
  signal    RUN_SYNC                 :  std_logic;
  signal    ATTEMPT_RESTART          :  std_logic;
  signal    FSM_TEMP                 :  std_logic;
  signal    FSM_HALT                 :  std_logic;

  signal    ACTIVE2                  :  std_logic;
  signal    CLKFBSTOP                :  std_logic;

  signal    DRP_DO                   :  std_logic_vector(15 DOWNTO 0);
  signal    DRP_DI                   :  std_logic_vector(15 DOWNTO 0);
  signal    DRP_DADDR                :  std_logic_vector(6 DOWNTO 0);
  signal    DRP_DRDY                 :  std_logic;
  signal    DRP_DEN                  :  std_logic;
  signal    DRP_DWE                  :  std_logic;
  signal    DCM_RST                  :  std_logic;
  signal    DCM_RST_int              :  std_logic;
  signal    DCM_LCK                  :  std_logic;

  signal    SAV_START                :  std_logic;
  signal    SAV_DONE                 :  std_logic;
  signal    EXE_START                :  std_logic;
  signal    EXE_DCMGO                :  std_logic;
  signal    EXE_DONE                 :  std_logic;

------------------------------------------------------------------------------------
--- Attributes  
------------------------------------------------------------------------------------

   attribute CLOCK_SIGNAL        : string;
   attribute RLOC                : string;
   attribute HU_SET              : string;
   attribute USE_CLOCK_ENABLE    : string;
   attribute ASYNC_REG : STRING ;

   attribute ASYNC_REG of RUN_SYNC0 : LABEL  is "TRUE";
   attribute HU_SET of RUN_SYNC0 : LABEL  is CompName&"_SYNCS" ;
   attribute HU_SET of RUN_SYNC1 : LABEL  is CompName&"_SYNCS" ;
   attribute RLOC of RUN_SYNC0   : LABEL  is "X0Y0";
   attribute RLOC of RUN_SYNC1   : LABEL  is "X0Y0";

   attribute ASYNC_REG of FSM_HALT0  : LABEL is "TRUE";
   attribute HU_SET of FSM_HALT0  : LABEL  is CompName&"_SYNCS";
   attribute HU_SET of FSM_HALT1  : LABEL  is CompName&"_SYNCS";
   attribute RLOC of FSM_HALT0    : LABEL  is "X0Y1";
   attribute RLOC of FSM_HALT1    : LABEL  is "X0Y1";

    attribute DLL_FREQUENCY_MODE : string;
    attribute DUTY_CYCLE_CORRECTION : string;
    attribute STARTUP_WAIT : string;
    attribute CLK_FEEDBACK : string;
--    attribute FEEDBACK : string;
    
    attribute DLL_FREQUENCY_MODE of DCM_ADV_INST : label is "LOW";
    attribute DUTY_CYCLE_CORRECTION of DCM_ADV_INST : label is "TRUE";
    attribute STARTUP_WAIT of DCM_ADV_INST : label is "FALSE";
    attribute CLK_FEEDBACK of DCM_ADV_INST : label is "1X";
--    attribute FEEDBACK of DCM_ADV_INST : label is "1X";

-------------------------------------------------------------------------------
-- Component declaration ------------------------------------------------------
-------------------------------------------------------------------------------
COMPONENT DETECTOR
    GENERIC (
      CompName         : string
     ); 
       PORT  (
         FACLK   :  in std_logic ;
         ACTIVE  :  out std_logic ;
         CLK     :  in  std_logic 
         );
END COMPONENT ;
 
COMPONENT  COUNT2TC_SYNC
       PORT  (
          CLK    : in std_logic ;
          RST    : in std_logic ; 
          TC     : out std_logic 
            );
END COMPONENT ;

COMPONENT  DRP_ROBOT
       PORT (
        DRP_DO        : in std_logic_vector(15 downto 0) ;
        DRP_DRDY      : in  std_logic ;
        DRP_DADDR     : out std_logic_vector(6 downto 0);
        DRP_DEN       : out std_logic;    
        DRP_DI        : out std_logic_vector(15 downto 0);
        DRP_DWE       : out std_logic ; 
        SAV_START     : in  std_logic ;
        SAV_DONE      : out std_logic ;
        EXE_START     : in  std_logic ; 
        EXE_DCMGO     : out std_logic ;
        EXE_DONE      : out std_logic ; 
        CLK           : in  std_logic           
        );
END COMPONENT ;




BEGIN

  ------------------------------------------------------------------------------
  -- Fabric accessible CLKIN signal.
  ------------------------------------------------------------------------------


    FACLK_INST : BUFG
               PORT MAP (
                        I      =>  CLKIN,
                        O      =>  CLKIN_BUFGED
                         );
 -- assign FACLK = USE_FX_SYNCLK ? CLKIN_BUFGED : CLKIN;

--   FACLK <= CLKIN_BUFGED when (USE_FX_SYNCLK) else CLKIN ;

NOBUFG: IF NOT USE_FX_SYNCLK GENERATE
 BEGIN
    FACLK <= CLKIN ;
 END GENERATE ;

USEBUFG : IF USE_FX_SYNCLK GENERATE
 BEGIN
    FACLK <= CLKIN_BUFGED ;
 END GENERATE ;


  ------------------------------------------------------------------------------
  -- Monitor FACLK for stop conditions.
  ------------------------------------------------------------------------------


  DETECTOR_INST : DETECTOR
      generic map (
        CompName         => CompName
      ) 
              PORT MAP (
                FACLK   =>  FACLK,
                ACTIVE  =>  ACTIVE,
                CLK    =>  CLK
                );

  COUNT2TC0 : COUNT2TC_SYNC
             PORT MAP (
                  CLK     => CLK,
                  RST     => ACTIVE,
                  TC      => FACLKSTOP
                   );

  DETECTOR_INST_2 : DETECTOR
      generic map (
        CompName         => CompName
      ) 
              PORT MAP (
                FACLK   =>  CLKFB,
                ACTIVE  =>  ACTIVE2,
                CLK    =>  CLK
                );

  COUNT2TC0_2 : COUNT2TC_SYNC
             PORT MAP (
                  CLK     => CLK,
                  RST     => ACTIVE2,
                  TC      => CLKFBSTOP
                   );

  ----------------------------------------------------------------------------
  -- Instantiate the flag flip flop that monitors for clock stop or reset.
  -- The two synchronizer flops should be located in the same slice.  Note
  -- that the RUN_FLAG is synchronized for use in the synchronous logic
  -- but is used asynchronously in deasserting the LOCKED signal.  Consider
  -- the following cases:
  -- 
  -- The user RST may assert during any FSM state, but may not meet the min
  -- pulse width requirement for the flag's CLR input.  This could occur
  -- if the timeout takes place and the clock happens to restart immediately
  -- after the timeout, or the applied user reset is too short in duration.
  -- Assuming the flag is one when it would be sensitive to RST:
  -- 
  -- 1.  Flag resolves to 1 without transient indeterminate value.
  --     * Event is "missed" which is acceptable since clock restarted.
  -- 2.  Flag resolves to 0 regardless of transient values.
  --     * Event is "detected" which is acceptable due to timeout.
  -- 3.  Flag resolves to 1 with transient indeterminate value.
  --     In this case, LOCKED may glitch if the FSM is in the RUN
  --     state.  Separately, depending on how the synchronizer
  --     resolves this event, the FSM may or may not exit RUN state.
  --     * If the FSM exits RUN, the event is "detected" which is
  --       acceptable due to timeout.  The FSM will deassert LOCKED.
  --     * If the FSM does not exit RUN, but LOCKED glitches, and the
  --       user takes action by resetting this module, the event is
  --       "detected" which is acceptable due to timeout.
  --     * If the FSM does not exit RUN, but LOCKED glitches, and the
  --       user takes no action, the event is "missed" which is
  --       acceptable since the clock has restarted.
  -- 
  -- ATTEMPT_RESTART enables the sampling of 1 at the rising edge of CLK
  -- during the EXERCISE state.  This is asynchronous with RST.
  -- In this state, LOCKED is not sensitive to the flag because it is
  -- masked by a state output.  Therefore, no glitches occur on LOCKED.
  -- However, the flag may fail to sample the 1 properly depending
  -- on the behavior of RST.  Assuming the flag is zero when it
  -- would be sensitive to ATTEMPT_RESTART at rising edges of CLK:
  -- 
  -- 1.  Flag resolves to 0 without transient indeterminate value.
  --     * FSM remains in EXERCISE, as restart was not succesful.
  --       This is acceptable behavior, FSM will try restart again.
  -- 2.  Flag resolves to 1 regardless of transient values.
  --     * FSM will exit EXERCISE, as restart was successful.
  --       This is acceptable behavior.
  -- 3.  Flag resolves to 0 with transient indeterminate value.
  --     Depending on how the synchronizer resolves this event,
  --     the FSM may or may not exit the EXERCISE state.
  --     * If the FSM does not exit the EXERCISE state, this
  --       is functionally the same as an unsuccessful restart,
  --       and the FSM tries again.  This is acceptable behavior.
  --     * If the FSM exits the EXERCISE state, it will return to
  --       the RUN state for one cycle and then transition back to
  --       EXERCISE.  LOCKED will not have time to assert.  This
  --       is acceptable behavior.
  ------------------------------------------------------------------------------


 -- always @(posedge CLK or posedge RST)
 -- begin
 --   if (RST) RUN_FLAG <= 1'b0;
 --   else if (FACLKSTOP) RUN_FLAG <= 1'b0;
 --   else if (ATTEMPT_RESTART) RUN_FLAG <= 1'b1;
 -- end

   proc1 : PROCESS (RST, CLK)
   BEGIN
     IF (RST = '1') THEN
         RUN_FLAG <= '0';
     ELSIF (CLK'EVENT AND CLK = '1') THEN
       IF (FACLKSTOP = '1') THEN
--       IF (FACLKSTOP = '1' or CLKFBSTOP = '1') THEN
         RUN_FLAG <= '0';
       ELSIF (ATTEMPT_RESTART = '1') THEN
         RUN_FLAG <= '1';
       END IF;
     END IF;
   END PROCESS;

   RUN_SYNC0 : FD
       PORT MAP (
            Q     =>  RUN_TEMP,
            D     =>  RUN_FLAG,
            C     =>  CLK );

 
   RUN_SYNC1 : FD
       PORT MAP (
            Q   =>  RUN_SYNC,
            D   =>  RUN_TEMP,
            C   =>  CLK) ;


  ------------------------------------------------------------------------------
  -- Another two synchronizer flops to create a synchronous disable for fsm.
  -- This ensures the fsm does not attempt to change state until some time
  -- after GSR has been released during the startup cycle.  The signal is
  -- also used to provide an "almost constant zero" output for the BUFGCTRL
  -- instantiated by the user.  Again, these two flops should be located in
  -- the same slice.
  ------------------------------------------------------------------------------

  
  FSM_HALT0 : FDP
         PORT MAP (
              Q    => FSM_TEMP,
              D    => '0',
              C    => CLK,
              PRE  => '0') ;


  FSM_HALT1 : FDP
         PORT MAP (
              Q    => FSM_HALT,
              D    => FSM_TEMP,
              C    => CLK,
              PRE  => '0') ;


   I1   <= FSM_HALT ;

  ------------------------------------------------------------------------------
  -- Instantiate the DCM_ADV.  Users may place additional attributes on this
  -- as required for their designs. 
  ------------------------------------------------------------------------------


   DCM_ADV_INST : DCM_ADV
     GENERIC MAP (
       DLL_FREQUENCY_MODE  => CONST_DLL_FREQUENCY_MODE,
       DFS_FREQUENCY_MODE  => CONST_DFS_FREQUENCY_MODE,
       CLK_FEEDBACK        => CONST_CLK_FEEDBACK ,
       CLKOUT_PHASE_SHIFT  => CONST_CLKOUT_PHASE_SHIFT ,
       PHASE_SHIFT         => CONST_PHASE_SHIFT,
       CLKDV_DIVIDE        => CONST_CLKDV_DIVIDE,
       CLKFX_MULTIPLY      => CONST_CLKFX_MULTIPLY,
       CLKFX_DIVIDE        => CONST_CLKFX_DIVIDE,
       CLKIN_DIVIDE_BY_2   => CONST_CLKIN_DIVIDE_BY_2,
       DESKEW_ADJUST       => CONST_DESKEW_ADJUST,
       FACTORY_JF          => CONST_FACTORY_JF,
       DCM_AUTOCALIBRATION => FALSE
    ) 

       PORT MAP (
        CLK0         =>  CLK0,
        CLK180       =>  CLK180,
        CLK270       =>  CLK270,
        CLK2X        =>  CLK2X,
        CLK2X180     =>  CLK2X180,
        CLK90        =>  CLK90,
        CLKDV        =>  CLKDV,
        CLKFX        =>  CLKFX,
        CLKFX180     =>  CLKFX180,
        DO           =>  DRP_DO,
        DRDY         =>  DRP_DRDY,
        LOCKED       =>  DCM_LCK,
        PSDONE       =>  PSDONE,
        CLKFB        =>  CLKFB,
        CLKIN        =>  CLKIN,
        DADDR        =>  DRP_DADDR,
        DCLK         =>  CLK,
        DEN          =>  DRP_DEN,
        DI           =>  DRP_DI,
        DWE          =>  DRP_DWE,
        PSCLK        =>  PSCLK,
        PSEN         =>  PSEN,
        PSINCDEC     =>  PSINCDEC,
        RST          =>  DCM_RST
        ) ;


  ------------------------------------------------------------------------------
  -- Instantiate the DRP_ROBOT that reads and writes the DCM configuration port.
  ------------------------------------------------------------------------------


  DRP_ROBOT_INST : DRP_ROBOT 
       PORT MAP(
        DRP_DO        =>  DRP_DO,
        DRP_DRDY      =>  DRP_DRDY,
        DRP_DADDR     =>  DRP_DADDR,
        DRP_DEN       =>  DRP_DEN,
        DRP_DI        =>  DRP_DI,
        DRP_DWE       =>  DRP_DWE,
        SAV_START     =>  SAV_START,
        SAV_DONE      =>  SAV_DONE,
        EXE_START     =>  EXE_START,
        EXE_DCMGO     =>  EXE_DCMGO,
        EXE_DONE      =>  EXE_DONE,
        CLK           =>  CLK
        ); 

  DO  <= DRP_DO;

  ------------------------------------------------------------------------------
  -- State Descriptions:
  ------------------------------------------------------------------------------
  -- SAVE:     Save DCM state; this only happens once.
  -- EXERCISE: Exercise the delay lines through the DRP.
  -- RESTORE:  Restore the DCM state, get ready to run.
  -- RUN:      Normal operating mode.
  ------------------------------------------------------------------------------


 dcm_fsm : process(CLK)
  begin
    If (CLK'event and CLK = '1') then

      If  (FSM_HALT = '0') then

        case DCM_STATE is

         when SAVE =>
            if (SAV_DONE = '1') then
               if (RUN_SYNC = '1') then
                  DCM_STATE <= RUN ;
               else
                  DCM_STATE <= EXERCISE ;
               end if ;
            else
               DCM_STATE <= SAVE ;
            end if;

         when EXERCISE => 
            if (RUN_SYNC = '1') then 
                  DCM_STATE <= RESTORE ;
               else
                  DCM_STATE <= EXERCISE ; 
            end if;

         when RESTORE => 
            if (EXE_DONE = '1') then 
               if (RUN_SYNC = '1') then 
                  DCM_STATE <= RUN ;
               else
                  DCM_STATE <= EXERCISE ; 
               end if ; 
            else 
               DCM_STATE <= RESTORE ; 
            end if;

         when RUN =>  
            if (RUN_SYNC = '1') then 
                  DCM_STATE <= RUN ; 
               else 
                  DCM_STATE <= EXERCISE ; 
            end if;

         when others      =>
            DCM_STATE  <= SAVE;
    
        end case;
      end if ;
    end if ;

end process ;  



  ------------------------------------------------------------------------------
  -- Output signals.
  ------------------------------------------------------------------------------

  -- Do an initial save at time zero after
  -- we are certain GSR is deasserted.  This
  -- is the only context save.

   -- assign SAV_START <= (DCM_STATE[2:0] == 3'b000) & !FSM_HALT;

process ( DCM_STATE , FSM_HALT )
begin

   if ( (DCM_STATE = "000" ) and ( FSM_HALT = '0' ) ) then
      SAV_START <= '1' ;
   else
      SAV_START <= '0' ;
   end if ;

end process ;

  -- Any time we are in the EXERCISE
  -- or initial SAVE state, attempt to
  -- restart (set the run flag).  If we
  -- are in the EXERCISE state, tell the
  -- drp robot to exercise the delay lines.

 -- assign ATTEMPT_RESTART = (DCM_STATE[2:1] == 2'b00);
 -- assign EXE_START = DCM_STATE[0];


EXE_START <= DCM_STATE(0) ;

process (DCM_STATE)
begin
   if (DCM_STATE(2 downto 1) = "00" ) then
      ATTEMPT_RESTART <= '1' ;
   else
      ATTEMPT_RESTART <= '0' ;
   end if;
end process ;


  -- Gate off the LOCKED signal.  As soon
  -- as a reset occurs or a clock stop is
  -- detected, RUN_FLAG will force LOCKED
  -- to zero asynchronously.  Then, the
  -- DCM_STATE[2] bit deasserts, keeping
  -- LOCKED at zero until the delay line
  -- exercise is complete and this FSM
  -- returns to the RUN state.

 -- assign LOCKED = DCM_STATE[2] & DCM_LCK & RUN_FLAG;

LOCKED <= DCM_STATE(2) and DCM_LCK and RUN_FLAG ;

  -- During actual delay line exercise
  -- the DCM input for CLKFB must be at
  -- logic zero.  Switch the BUFGCTRL.

 -- assign S1 = EXE_DCMGO;
 -- assign S0 = !EXE_DCMGO;
    
    S1 <= EXE_DCMGO ;
    S0 <= NOT EXE_DCMGO ;

  --The DCM must be active during the
  -- delay line exercise.  At other times
  -- assert the reset during the RESTORE
  -- and SAVE states.  In both cases, the
  -- state will last in excess of three
  -- CLKIN cycles, satisfying the DCM
  -- reset requirement.

 -- assign DCM_RST = !DCM_STATE[0] & !DCM_STATE[2];

    DCM_RST_int  <= (NOT DCM_STATE(0)) and (NOT DCM_STATE(2)) ;

   DCMRST_SYNC : FDP
       PORT MAP (
            Q     =>  DCM_RST,
            D     =>  DCM_RST_int,
            PRE   =>  '0',
            C     =>  CLK );


end  STANDBY ; 



