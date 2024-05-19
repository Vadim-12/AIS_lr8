data='Агарков Вадим Александрович | 24.04.2003 | Технологический лицей города Сыктывкара | Информационные системы и технологии'
filename='ИСТ-112АгарковВ.А.ЛР4а_текст'

uppercased_chars=$(echo 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZ'| iconv -t CP1251)
lowercased_chars=$(echo 'абвгдеёжзийклмнопрстуфхцчшщъыьэюяabcdefghijklmnopqrstuvwxyz'| iconv -t CP1251)

ru_uppercased_chars=$(echo 'АБВГДЕЗИЙКЛМНОПРСТУФЪЫЬЭ' | iconv -t CP1251)
en_uppercased_chars=$(echo 'ABVGDEZIYKLMNOPRSTUF"Y"E' | iconv -t CP1251)

declare -A difficult_translit=(["Ё"]="YO" ["Ж"]="ZH" ["Х"]="KH" ["Ц"]="TS" ["Ч"]="CH" ["Ш"]="SH" ["Щ"]="SHCH" ["Ю"]="YU" ["Я"]="YA")

condition="$(for char in "${!difficult_translit[@]}"; do echo "awk '{gsub(\"$(echo $char | iconv -t CP1251)\",\"$(echo ${difficult_translit[$char]} | iconv -t CP1251)\");print}' |"; done)"

yes $data | head -n 500000 | iconv -f UTF8 -t CP1251 | tr $lowercased_chars $uppercased_chars | iconv -f CP1251 -t CP866 | iconv -f CP866 -t CP1251 | tr "$ru_uppercased_chars" "$en_uppercased_chars" | eval ${condition:0:-1} > $fileName.txt

zip $fileName.zip $fileName.txt

rm $fileName.txt
