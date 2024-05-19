data='Агарков Вадим Александрович | 24.04.2003 | Технологический лицей города Сыктывкара | Информационные системы и технологии'
fileName='ИСТ-112АгарковВ.А.ЛР4б_текст'

uppercased_chars='АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ'
lowercased_chars='абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz'

ru_uppercased_chars='АБВГДЕЗИЙКЛМНОПРСТУФЪЫЬЭ'
en_uppercased_chars='ABVGDEZIYKLMNOPRSTUF"Y"E'

declare -A translit=(["Ё"]="YO" ["Ж"]="ZH" ["Х"]="KH" ["Ц"]="TS" ["Ч"]="CH" ["Ш"]="SH" ["Щ"]="SHCH" ["Ю"]="YU" ["Я"]="YA")

yes $data | head -n 500000 |sed "y/$lowercased_chars/$uppercased_chars/" | iconv -f UTF8 -t CP1251 | iconv -f CP1251 -t CP866 | iconv -f CP866 -t CP1251 > $fileName.txt

cat $fileName.txt | iconv -f CP1251 -t UTF8 | sed "y/$ru_uppercased_chars/$en_uppercased_chars/" > $fileName.tmp
sed -i ''"$(for char in "${!translit[@]}"; do echo "s/$char/${translit[$char]}/g;"; done)"'' "$fileName.tmp"

cat $fileName.tmp | iconv -f UTF8 -t CP1251 > $fileName.txt
rm $fileName.tmp

zip $fileName.zip $fileName.txt

rm $fileName.txt
