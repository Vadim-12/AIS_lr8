@echo off

reg add "HKCU\Software\Microsoft\Command Processor" /v DisableUNCCheck /t REG_DWORD /d 1

chcp 65001 > nul
echo Агарков Вадим Александрович ^| 24.04.2003 ^| Технологический лицей города Сыктывкара ^| Информационные системы и технологии > IST-112AgarkovV.A.LR2_text.txt

timeout /t 100 /nobreak > nul