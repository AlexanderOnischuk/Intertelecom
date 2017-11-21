@echo off
title Rediall Intertelecom on date: %date% & color 0A

::ßêèé ñàéò ï³íãóâàòè
   SET srv=google.com

::×àñ î÷³êóâàííÿ äëÿ ïåðåâ³ðêè ç'ºäíàííÿ â ñåêóíäàõ
   SET wait=60

::Íàçâà ç'ºäíàííÿ â Ïàíåë³ Óïðàâë³ííÿ (ÎÁÎÂ'ßÇÊÎÂÎ!!!)
   SET con=Intertelecom

::Ëîã³í (ÿêùî íåîáõ³äíî)
   SET logn=

::Ïàðîëü (ÿêùî íåîáõ³äíî)
   SET pas=

::Âåðñ³ÿ
   SET ver=ver.1.1.5
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:start
::Ïî÷àòêîâà ³íôîðìàö³ÿ òà âèçíà÷åííÿ íàÿâíîñò³ ³íòåðíåòó
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
::Ïðèìóñîâå â³äêëþ÷åííÿ
  echo ...
  echo %date% %time% - Reconnecting...
  set ARG=0
  rasdial /disconnect > nul

:dialing
::Ï³äêëþ÷åííÿ ³íòåðíåòó
  echo ...
  echo Reconnecting after 3 seconds...
  timeout /T 3 > nul
  set /a ARG=ARG+1
  echo Connect to %con%...
  rasdial "%con%" %logn% %pas% > nul && time /T && echo connected to "%con%" || goto dialing > nul
  echo %date% %time% Connecting N %ARG%.

:pinging
::Çàòðèìêà ïåðåä ï³íãóâàííÿì ïðè çáî¿ ìåðåæ³
  echo ...
  echo Waiting %wait% sec...
  echo ...
  timeout /T %wait%

:start_pinging
::Âèçíà÷åííÿ íàÿâíîñò³ ðîçðèâó çâ'ÿçêó
  echo ...
  echo Pinging...
  ping %srv% && goto pinging || echo Failure ping =^> pinging... && goto retry_pinging > nul

:retry_pinging
::Ïîâòîðíå ï³íãóâàííÿ äëÿ ïåðåï³äêëþ÷åííÿ ÿêùî ðîçðèâ äîñ³ º
  echo ...
  echo again pinging...
  ping %srv% > nul && goto pinging || echo Failure ping =^> Disconnect... && goto redialing > nul
  
