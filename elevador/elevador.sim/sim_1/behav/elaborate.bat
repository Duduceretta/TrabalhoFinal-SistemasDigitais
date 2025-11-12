@echo off
set xv_path=C:\\Xilinx\\Vivado\\2015.1\\bin
call %xv_path%/xelab  -wto 1f6f3b1fdd4847268d37fcf2fc41a989 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot tb_elevador3andares_behav xil_defaultlib.tb_elevador3andares -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
