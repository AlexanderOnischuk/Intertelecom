@echo off
TITLE Dial Intertelecom on date: %date% & COLOR 0A
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Intertelecom.bat - The automatic connection script for the permanent connection of the USB-modem.
::First in the Network Control Panel you must rename the connection to Intertelecom, otherwise this script will not be able to connect!
::This script can be inserted into the Autostart Windows and if the modem is permanently connected the system will automatically connect to the Internet after turning on the modem failure or crash.
::By default the script checks every time the presence of the internet, if there is no such thing - it re-combines on its own.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET "con=Intertelecom" &:: Name connection in Control Panel !!!
SET "srv=google.com" &:: What pinging?
SET "wait=60" &:: Wait time for check (in seconds)
SET "logn=" &:: Login (if you need)
SET "pas=" &:: Password (if you need)
SET "e=echo:" &:: Other variables for shortly code.

:start &:: --Initial information and definition of the availability of the Internet--
  echo -----------------------------------
  echo Redialling Intertelecom - ver.1.2.0
  echo -----------------------------------
  echo Created by ALExorON (c), 08.07.2017
  echo -----------------------------------
  %e%
  echo Current time: %time%
  echo Current date: %date%
  %e%
  echo Pinging to %srv%...
  ping %srv% && goto pinging || echo Failure ping =^> Connect... && goto dialing > nul

:redialing &:: --Forced disconnect--
  %e%
  echo %date% %time% - Reconnecting...
  set ARG=0
  rasdial /disconnect > nul

:dialing &:: --Internet connection--
  %e%
  echo Reconnecting after 2 seconds...
  timeout /T 2 > nul
  set /a ARG=ARG+1
  rasdial "%con%" %logn% %pas% > nul && time /T && echo connected to "%con%" || goto dialing > nul
  echo %date% %time% Connecting N %ARG%.
  goto start_pinging > nul

:pinging &:: --Delay before pinging in case of network failure--
  %e%
  echo Waiting %wait% sec...
  %e%
  timeout /T %wait%

:start_pinging &:: --Determining the existence of a communication break--
  cls
  echo Pinging...
  ping %srv% && goto pinging || echo Failure ping =^> pinging... && goto retry_pinging > nul

:retry_pinging &:: --Repeat ping for reconnection if there is still a gap--
  %e%
  echo Again pinging...
  ping %srv% > nul && goto pinging || echo Failure ping =^> Disconnect... && goto redialing > nul
