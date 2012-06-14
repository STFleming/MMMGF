-- fpcore_pkg.vhd
-- by Brittle 2009

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

PACKAGE fpcore IS

  COMPONENT fpadd_sp IS
    PORT (
      a: IN std_logic_VECTOR(31 downto 0);
      b: IN std_logic_VECTOR(31 downto 0);
      clk: IN std_logic;
      sclr: IN std_logic;
      ce: IN std_logic;
      result: OUT std_logic_VECTOR(31 downto 0));
  END component;

  COMPONENT fpsub_sp IS
    PORT (
      a: IN std_logic_VECTOR(31 downto 0);
      b: IN std_logic_VECTOR(31 downto 0);
      clk: IN std_logic;
      sclr: IN std_logic;
      ce: IN std_logic;
      result: OUT std_logic_VECTOR(31 downto 0));
  END component;

  COMPONENT fpmul_sp IS
    PORT (
      a: IN std_logic_VECTOR(31 downto 0);
      b: IN std_logic_VECTOR(31 downto 0);
      clk: IN std_logic;
      sclr: IN std_logic;
      ce: IN std_logic;
      result: OUT std_logic_VECTOR(31 downto 0));
  END component;

  COMPONENT fpdiv_sp IS
    PORT (
      a: IN std_logic_VECTOR(31 downto 0);
      b: IN std_logic_VECTOR(31 downto 0);
      clk: IN std_logic;
      sclr: IN std_logic;
      ce: IN std_logic;
      result: OUT std_logic_VECTOR(31 downto 0));
  END component;

  COMPONENT fpsqr_sp IS
    PORT (
      a: IN std_logic_VECTOR(31 downto 0);
      clk: IN std_logic;
      sclr: IN std_logic;
      ce: IN std_logic;
      result: OUT std_logic_VECTOR(31 downto 0));
  END component;

  COMPONENT fpf2i_sp IS
    port (
    a: IN std_logic_VECTOR(31 downto 0);
    clk: IN std_logic;
    sclr: IN std_logic;
    ce: IN std_logic;
    result: OUT std_logic_VECTOR(31 downto 0));
  END COMPONENT;

  COMPONENT fpi2f_sp IS
    port (
    a: IN std_logic_VECTOR(31 downto 0);
    clk: IN std_logic;
    sclr: IN std_logic;
    ce: IN std_logic;
    result: OUT std_logic_VECTOR(31 downto 0));
  END COMPONENT;

END;
