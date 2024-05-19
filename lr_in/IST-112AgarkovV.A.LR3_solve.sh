#!/bin/bash

data="Агарков Вадим Александрович | 24.04.2003 | Технологический лицей города Сыктывкара | Информационные системы и технологии"
amount=100000
tmp_filename=IST-112AgarkovV.A.LR3_tmp.txt
total_filename=IST-112AgarkovV.A.LR3_total.txt

encoded_utf8=$data

yes "$encoded_utf8" | head -$amount > $tmp_filename
cp $tmp_filename $total_filename
cat $tmp_filename | iconv -f UTF8 -t 866 >> $total_filename
cat $tmp_filename | iconv -f UTF8 -t CP1251 >> $total_filename
cat $tmp_filename | iconv -f UTF8 -t KOI8-R >> $total_filename

rm $tmp_filename
