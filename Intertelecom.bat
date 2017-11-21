@echo off
title Redialling Intertelecom on date: %date% & color 0A
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Intertelecom.bat - The automatic connection script for the permanent connection of the program NiceHash for extraction of bitcoin coins (mining).
::First, in the Network Control Panel, you must rename the connection to Intertelecom, otherwise this script will not be able to connect !!!!
::This script can be inserted into the Autostart system, and if the modem is permanently connected, the system will automatically connect to the Internet after turning on the PC, modem failure or crash.
::By default, the script checks every time the presence of the internet, if there is no such thing - it re-combines on its own.
::::::::::::::::::::::::::::::
:: ALExorON (c), 08.07.2017 ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::What pinging?
   SET srv=google.com
::Wait time for check (in seconds)
   SET wait=60
::Name in Control Panel (necessarily)!!!
   SET con=Intertelecom
::Login (if you need)
   SET logn=
::Password (if you need)
   SET pas=
::Current Version this file
   SET ver=ver.1.1.5
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:start
::Initial information and definition of the availability of the Internet
  echo -----------------------------------
  echo Redialling Intertelecom - %ver%
  echo -----------------------------------
  echo Created by ALExorON (c), 08.07.2017
  echo -----------------------------------
  echo ...
  echo Current date: %date%
  echo Current time: %time%
  echo ...
  echo Pinging to %srv%...
  ping %srv% > nul && goto pinging || echo Failure ping =^> Connect... && goto dialing > nul

:redialing
::Forced disconnect
  echo ...
  echo %date% %time% - Reconnecting...
  set ARG=0
  rasdial /disconnect > nul

:dialing
::Internet connection
  echo ...
  echo Reconnecting after 3 seconds...
  timeout /T 3 > nul
  set /a ARG=ARG+1
  echo Connect to %con%...
  rasdial "%con%" %logn% %pas% > nul && time /T && echo connected to "%con%" || goto dialing > nul
  echo %date% %time% Connecting N %ARG%.

:pinging
::Delay before pinging in case of network failure
  echo ...
  echo Waiting %wait% sec...
  echo ...
  timeout /T %wait%

:start_pinging
::Determining the existence of a communication break
  echo ...
  echo Pinging...
  ping %srv% && goto pinging || echo Failure ping =^> pinging... && goto retry_pinging > nul

:retry_pinging
::Repeat ping for reconnection if there is still a gap
  echo ...
  echo again pinging...
  ping %srv% > nul && goto pinging || echo Failure ping =^> Disconnect... && goto redialing > nul
  
