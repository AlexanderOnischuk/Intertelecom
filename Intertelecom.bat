@echo off
title Rediall Intertelecom on date: %date% & color 0A
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Intertelecom.bat - ������ ������������� ���������� ��������� ��� ��������� ��'���� �������� NiceHash ��� ��������� ����� ������ (�������).
::�������� � ����� ��������� �������� ��������� ������������� ���������� � Intertelecom, ������ ��� ������ �� ����� �����������!!!!
::��� ������ ����� �������� � ������������ �������, � ���� ����� ������� ����������, ������� ����������� ��������������� �� ��������� ���� ��������� ��, ���� ������ �� ���� �����.
::�� ������������ ������ ����� ������� �������� �������� ���������, ���� ������ ���� - ����������� ���������.
::::::::::::::::::::::::::::::
:: ALExorON (c), 08.07.2017 ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::���� ���� ��������
   SET srv=google.com

::��� ���������� ��� �������� �'������� � ��������
   SET wait=60

::����� �'������� � ����� ��������� (����'������!!!)
   SET con=Intertelecom

::���� (���� ���������)
   SET logn=

::������ (���� ���������)
   SET pas=

::�����
   SET ver=ver.1.1.5
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:start
::��������� ���������� �� ���������� �������� ���������
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
::��������� ����������
  echo ...
  echo %date% %time% - Reconnecting...
  set ARG=0
  rasdial /disconnect > nul

:dialing
::ϳ��������� ���������
  echo ...
  echo Reconnecting after 3 seconds...
  timeout /T 3 > nul
  set /a ARG=ARG+1
  echo Connect to %con%...
  rasdial "%con%" %logn% %pas% > nul && time /T && echo connected to "%con%" || goto dialing > nul
  echo %date% %time% Connecting N %ARG%.

:pinging
::�������� ����� ���������� ��� ��� �����
  echo ...
  echo Waiting %wait% sec...
  echo ...
  timeout /T %wait%

:start_pinging
::���������� �������� ������� ��'����
  echo ...
  echo Pinging...
  ping %srv% && goto pinging || echo Failure ping =^> pinging... && goto retry_pinging > nul

:retry_pinging
::�������� ��������� ��� �������������� ���� ������ ��� �
  echo ...
  echo again pinging...
  ping %srv% > nul && goto pinging || echo Failure ping =^> Disconnect... && goto redialing > nul
  