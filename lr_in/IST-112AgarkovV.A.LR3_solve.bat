@echo off
setlocal enabledelayedexpansion

set "data=Агарков Вадим Александрович | 24.04.2003 | Технологический лицей города Сыктывкара | Информационные системы и технологии"
set "amount=100000"
set "tmp_filename=IST-112AgarkovV.A.LR3_tmp.txt"
set "total_filename=IST-112AgarkovV.A.LR3_total.txt"

set "encoded_utf8=!data!"

(for /l %%i in (1,1,%amount%) do (
    echo !encoded_utf8!
)) > %tmp_filename%

copy %tmp_filename% %total_filename%
chcp 866 > nul
type %tmp_filename% >> %total_filename%
chcp 1251 > nul
type %tmp_filename% >> %total_filename%
chcp 20866 > nul
type %tmp_filename% >> %total_filename%

del %tmp_filename%
