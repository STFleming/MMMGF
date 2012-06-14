#!/usr/bin/perl

use Cwd;
use File::Copy;
use File::Find;
use File::Path;

$date = scalar localtime();

########## ########## ########## ########## ##########

# read in configuration parameters from file
print "Reading application configuration parameters ... ";
foreach (<>) {
  chomp;
  s/#.*//;
  if (! /^$/) {
    ($key, $value) = split("=", $_);
    $cfg{$key} = $value;
  }
}
print "Done!\n";

########## ########## ########## ########## ##########

# copy skeleton directory structure
$appdir = cwd();
$appdir =~ s/builder/$cfg{'APPLICATION_NAME'}/;
print "Creating directory structure in $appdir ... ";
find \&dircpy, 'skeleton';
print "Done!\n";

sub dircpy {
  my $dstdir = $File::Find::name;
  $dstdir =~ s/.*skeleton/$appdir/;
  if ($dstdir !~ /\/\.svn/ && -d && ! -e $dstdir) {
    mkdir ($dstdir) || die "cannot create dir [$dstdir]\n";
  }
}

########## ########## ########## ########## ##########

# config FPGA makefile
print "Configuring FPGA files ... ";

$mclk_freq = 1000/$cfg{'MCLK_PERIOD'};
$mclk_freq =~ s/(\d+\.\d\d)\d*/\1/;
$static_freq = $cfg{'MCLK_PERIOD'} - 0.25;

find \&fpga_cfg, 'skeleton/fpga';

# replace all common terms
sub fpga_cfg {
  my $dstdir = $File::Find::name;
  $dstdir =~ s/.*skeleton/$appdir/;

  if ($dstdir !~ /\/\.svn/ && -f) {
    open SKE_FILE, "<$_";
    open APP_FILE, ">$dstdir";
    while (<SKE_FILE>) {
      s/<<<APPLICATION_NAME>>>/$cfg{'APPLICATION_NAME'}/g;
      s/<<<MCLK_PERIOD>>>/$cfg{'MCLK_PERIOD'}/g;
      s/<<<MCLK_FREQ>>>/$mclk_freq/g;
      s/<<<STATIC_PERIOD>>>/$static_freq/g;
      s/<<<EMAIL>>>/$cfg{'EMAIL'}/g;
      s/<<<DATE>>>/$date/g;
      print APP_FILE $_;
    }
    close SKE_FILE;
    close APP_FILE;
  }
}

print " Done!\n";

########## ########## ########## ########## ##########

# customize src/userapp.c
print "Customizing src/userapp.c ... ";

open SKE_FILE, "<skeleton/fpga/src/userapp.c";
open APP_FILE, ">$appdir/fpga/src/userapp.c";
while (<SKE_FILE>) {

  # create variables
  if (/<<<VAR_DEC>>>/) {
    print APP_FILE "/* ---- Axel Builder Variable ---- begin ---- */\n";

    # create register variables
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      print APP_FILE "  $cfg{$name.'_TYPE'} $cfg{$name.'_NAME'}";
      print APP_FILE " = $cfg{$name.'_VALUE'}" if exists $cfg{$name.'_VALUE'};
      print APP_FILE ";\n";
    }

    # create fifo variables
    for ($i=0; $i<$cfg{'FIFO_CNT'}; $i++) {
      $name = 'FIFO'.$i;
      print APP_FILE "  int $cfg{$name.'_NAME'}_fifodepth = $cfg{$name.'_DPETH'};\n";
      print APP_FILE "  $cfg{$name.'_TYPE'} $cfg{$name.'_NAME'}";
      print APP_FILE " = $cfg{$name.'_VALUE'}" if exists $cfg{$name.'_VALUE'};
      print APP_FILE ";\n";
    }

    # create data block vairables
    for ($i=0; $i<$cfg{'DAT_CNT'}; $i++) {
      $name = 'DAT'.$i;
      print APP_FILE "  $cfg{$name.'_TYPE'} *$cfg{$name.'_NAME'} = NULL;\n";
    }
    print APP_FILE "/* ---- Axel Builder Variable ---- end ---- */\n";
  } 
  
  # create memory for data blocks
  elsif (/<<<DAT_INI>>>/) {
    for ($i=0; $i<$cfg{'DAT_CNT'}; $i++) {
      $name = 'DAT'.$i;
      print APP_FILE <<EOF
//  $cfg{$name.'_NAME'} = ($cfg{$name.'_TYPE'} *)malloc(sizeof($cfg{$name.'_TYPE'})*$cfg{$name.'_SIZE'});
EOF
    }
  } 
  
  # sent data to FPGA
  elsif (/<<<DATA_HOST2FPGA>>>/) {

    # set parameters in registers
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'w') {
        $reg_loc = $i + 1;
        print APP_FILE "  fpgaReg[USER_REG+$reg_loc] = $cfg{$name.'_NAME'};\n";
        $user_reg_cnt++;
      }
    }

    # send data through FIFO
    for ($i=0; $i<$cfg{'FIFO_CNT'}; $i++) {
      $name = 'FIFO'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'w') {
        $reg_loc = $cfg{'REG_CNT'}+$i*2+1;
        print APP_FILE <<EOF;
  for (i=0; i<$cfg{$name.'_DEPTH'}; i++)
    fpgaReg[USER_REG+$reg_loc] = $cfg{$name.'_NAME'};
EOF
      }
    }

    # send block data to FPGA DDR2 SDRAM
    for ($i=0; $i<$cfg{'DAT_CNT'}; $i++) {
      $name = 'DAT'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'w') {
        print APP_FILE <<EOF;
  if (fpga_dmawrite($cfg{$name.'_NAME'}, sizeof($cfg{$name.'_TYPE'})*$cfg{$name.'_SIZE'}, $cfg{$name.'_ADDR'})) {
    fpga_cleanup();
    return -1;
  }
EOF
      }
    }
  }

  # kick start FPGA
  elsif (/<<<KICK_START>>>/) {
    print APP_FILE "  fpgaReg[USER_REG] = 1;\n";
  }

  # wait until FPGA finish
  elsif (/<<<WAIT_FINISH>>>/) {
    print APP_FILE "  regval = 0;\n";
    print APP_FILE <<EOF
  while ((regval&finish_code) != finish_code)
    regval = fpgaReg[USER_REG];
EOF
  }
  
  # read data from FPGA
  elsif (/<<<DATA_FPGA2HOST>>>/) {

    # read status in registers
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'r') {
        $reg_loc = $i + 1;
        print APP_FILE "  $cfg{$name.'_NAME'} = fpgaReg[USER_REG+$reg_loc];\n";
        $user_reg_cnt++;
      }
    }

    # get data through FIFO
    for ($i=0; $i<$cfg{'FIFO_CNT'}; $i++) {
      $name = 'FIFO'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'r') {
        $reg_loc = $cfg{'REG_CNT'}+$i*2+1;
        print APP_FILE <<EOF;
  regval = fpgaReg[USER_REG+$reg_loc+1];
  for (i=0; i<regval; i++)
    $cfg{$name.'_NAME'} = fpgaReg[USER_REG+$reg_loc];
EOF
      }
    }

    # send block data to FPGA DDR2 SDRAM
    for ($i=0; $i<$cfg{'DAT_CNT'}; $i++) {
      $name = 'DAT'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'r') {
        print APP_FILE <<EOF;
  if (fpga_dmaread($cfg{$name.'_NAME'}, sizeof($cfg{$name.'_TYPE'})*$cfg{$name.'_SIZE'}, $cfg{$name.'_ADDR'})) {
    fpga_cleanup();
    return -1;
  }
EOF
      }
    }
  }

  # free memory of data blocks
  elsif (/<<<DAT_FIN>>>/) {
    for ($i=0; $i<$cfg{'DAT_CNT'}; $i++) {
      $name = 'DAT'.$i;
      print APP_FILE "//  free($cfg{$name.'_NAME'});\n";
    }
  } 
  
  # replace common terms
  else {
    s/<<<APPLICATION_NAME>>>/$cfg{'APPLICATION_NAME'}/g;
    s/<<<MCLK_PERIOD>>>/$cfg{'MCLK_PERIOD'}/g;
    s/<<<MCLK_FREQ>>>/$mclk_freq/g;
    s/<<<STATIC_PERIOD>>>/$static_freq/g;
    s/<<<EMAIL>>>/$cfg{'EMAIL'}/g;
    s/<<<DATE>>>/$date/g;
    print APP_FILE $_;
  }
}
close SKE_FILE;
close APP_FILE;

print " Done!\n";

########## ########## ########## ########## ##########

# customize hdl/user_app.vhd
print "Customizing hdl/user_app.vhd ... ";

open SKE_FILE, "<skeleton/fpga/hdl/user_app.vhd";
open APP_FILE, ">$appdir/fpga/hdl/user_app.vhd";
while (<SKE_FILE>) {

  # set register port
  if (/<<<REG_PORT>>>/) {
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      print APP_FILE "  $cfg{$name.'_NAME'} : ";
      if ($cfg{$name.'_DIRECTION'} eq 'r') {
        print APP_FILE "out ";
      }
      else {
        print APP_FILE "in ";
      }
      print APP_FILE "std_logic_vector(31 downto 0);\n";
    }
  }

  # set memory port
  elsif (/<<<MEM_PORT>>>/) {
    for ($i=0; $i<$cfg{'BANK_CNT'}; $i++) {
      print APP_FILE <<EOF
  rdy$i   : in  std_logic;
  req$i   : out std_logic;
  vld$i   : in  std_logic;
  addr$i  : out std_logic_vector(max_address_width-1 downto 0);
  data$i  : in  std_logic_vector(127 downto 0);
EOF
    }
  }

  # create signals
  elsif (/<<<REG_SIGNAL>>>/) {
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      print APP_FILE "  signal $cfg{$name.'_NAME'} : std_logic_vector(31 downto 0);\n";
    }
  }

  # set idle memory interface
  elsif (/<<<BANK_CNT>>>/) {
    s/<<<BANK_CNT>>>/$cfg{'BANK_CNT'}/g;
    print APP_FILE $_;
  }
  elsif (/<<<MEM_BE>>>/) {
    for ($i=0; $i<$cfg{'BANK_CNT'}; $i++) {
      print APP_FILE "  be($i) <= (others => '1');\n";
    }
  }

  # set register map
  elsif (/<<<REG_MAP>>>/) {
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      print APP_FILE "  $cfg{$name.'_NAME'} => $cfg{$name.'_NAME'},\n";
    }
  }

  # set memory map
  elsif (/<<<MEM_MAP>>>/) {
    for ($i=0; $i<$cfg{'BANK_CNT'}; $i++) {
      print APP_FILE <<EOF
  rdy$i   => rdy($i),
  req$i   => req($i),
  vld$i   => vld($i),
  addr$i  => a($i),
  data$i  => d($i),
EOF
    }
  }

  # connect to host register interface
  elsif (/<<<REG_IO>>>/) {
    print APP_FILE "  en <= not rst;\n";
    print APP_FILE "  start <= reg_in(0) and reg_wr(0);\n";
    print APP_FILE "  reg_out(0) <= done;\n";
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      if ($cfg{$name.'_DIRECTION'} eq 'w') {
        $reg_wr = 4 + $i*4;
        print APP_FILE <<EOF
  U_REG_$cfg{$name.'_NAME'}: process (clk)
    variable i : integer;
  begin
    if rising_edge(clk) then
      for i in 3 downto 0 loop
        if reg_wr($reg_wr+i) = '1' then
          $cfg{$name.'_NAME'}(i*8+7 downto i*8) <= reg_in(i*8+7 downto i*8);
        end if;
      end loop;
    end if;
  end process;
EOF
      }
      else {
        $reg_bit_low = 32 + $i * 32;
        $reg_bit_high = 32 + $i * 32 + 31;
        print APP_FILE "  reg_out($reg_bit_high downto $reg_bit_low) <= $cfg{$name.'_NAME'};\n";
      }
    }
  }

  # replace common terms
  else {
    s/<<<APPLICATION_NAME>>>/$cfg{'APPLICATION_NAME'}/g;
    s/<<<MCLK_PERIOD>>>/$cfg{'MCLK_PERIOD'}/g;
    s/<<<MCLK_FREQ>>>/$mclk_freq/g;
    s/<<<STATIC_PERIOD>>>/$static_freq/g;
    s/<<<EMAIL>>>/$cfg{'EMAIL'}/g;
    s/<<<DATE>>>/$date/g;
    print APP_FILE $_;
  }
}

close SKE_FILE;
close APP_FILE;

print " Done!\n";

########## ########## ########## ########## ##########

# customizing hdl/pe.vhd
print "Customizing hdl/pe.vhd ... ";

open SKE_FILE, "<skeleton/fpga/hdl/pe.vhd";
open APP_FILE, ">$appdir/fpga/hdl/pe.vhd";
while (<SKE_FILE>) {

  # set register port
  if (/<<<REG_PORT>>>/) {
    for ($i=0; $i<$cfg{'REG_CNT'}; $i++) {
      $name = 'REG'.$i;
      print APP_FILE "  $cfg{$name.'_NAME'} : ";
      if ($cfg{$name.'_DIRECTION'} eq 'r') {
        print APP_FILE "out ";
      }
      else {
        print APP_FILE "in ";
      }
      print APP_FILE "std_logic_vector(31 downto 0);\n";
    }
  }

  # set memory port
  elsif (/<<<MEM_PORT>>>/) {
    for ($i=0; $i<$cfg{'BANK_CNT'}; $i++) {
      print APP_FILE <<EOF
  rdy$i   : in  std_logic;
  req$i   : out std_logic;
  vld$i   : in  std_logic;
  addr$i  : out std_logic_vector(max_address_width-1 downto 0);
  data$i  : in  std_logic_vector(127 downto 0);
EOF
    }
  }

  # replace common terms
  else {
    s/<<<APPLICATION_NAME>>>/$cfg{'APPLICATION_NAME'}/g;
    s/<<<MCLK_PERIOD>>>/$cfg{'MCLK_PERIOD'}/g;
    s/<<<MCLK_FREQ>>>/$mclk_freq/g;
    s/<<<STATIC_PERIOD>>>/$static_freq/g;
    s/<<<EMAIL>>>/$cfg{'EMAIL'}/g;
    s/<<<DATE>>>/$date/g;
    print APP_FILE $_;
  }

}

close SKE_FILE;
close APP_FILE;

print " Done!\n";
