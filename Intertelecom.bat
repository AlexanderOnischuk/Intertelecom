@echo off
title Rediall Intertelecom on date: %date% & color 0A
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Intertelecom.bat - Скрипт автоматичного підключення інтернету для постійного зв'язку програми NiceHash для добування монет біткоїну (майнінгу).
::Спочатку в Панелі управління мережами необхідно перейменувати підключення в Intertelecom, інакше цей скрипт не зможе підключитись!!!!
::Цей скрипт можна вставити в Автозагрузку системи, і якщо модем постійно підключений, система автоматично підключатиметься до інтернету після включення ПК, збоїв модему чи збоїв вишки.
::По замовчуванню скрипт кожну хвилину перевіряє наявність інтернету, якщо такого немає - перепідключає самостійно.
::::::::::::::::::::::::::::::
:: ALExorON (c), 08.07.2017 ::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::Який сайт пінгувати
   SET srv=google.com

::Час очікування для перевірки з'єднання в секундах
   SET wait=60

::Назва з'єднання в Панелі Управління (ОБОВ'ЯЗКОВО!!!)
   SET con=Intertelecom

::Логін (якщо необхідно)
   SET logn=

::Пароль (якщо необхідно)
   SET pas=

::Версія
   SET ver=ver.1.1.5
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:start
::Початкова інформація та визначення наявності інтернету
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
::Примусове відключення
  echo ...
  echo %date% %time% - Reconnecting...
  set ARG=0
  rasdial /disconnect > nul

:dialing
::Підключення інтернету
  echo ...
  echo Reconnecting after 3 seconds...
  timeout /T 3 > nul
  set /a ARG=ARG+1
  echo Connect to %con%...
  rasdial "%con%" %logn% %pas% > nul && time /T && echo connected to "%con%" || goto dialing > nul
  echo %date% %time% Connecting N %ARG%.

:pinging
::Затримка перед пінгуванням при збої мережі
  echo ...
  echo Waiting %wait% sec...
  echo ...
  timeout /T %wait%

:start_pinging
::Визначення наявності розриву зв'язку
  echo ...
  echo Pinging...
  ping %srv% && goto pinging || echo Failure ping =^> pinging... && goto retry_pinging > nul

:retry_pinging
::Повторне пінгування для перепідключення якщо розрив досі є
  echo ...
  echo again pinging...
  ping %srv% > nul && goto pinging || echo Failure ping =^> Disconnect... && goto redialing > nul
  