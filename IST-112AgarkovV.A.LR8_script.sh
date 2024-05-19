#!/bin/bash

# Directories
input_directory="./lr_in/"
output_directory="../lr_pdf/"
doc_directory="../lr_doc/"

# Log file
log_file='../convert.log.txt'
# mv 'convert.log.txt' ../

# Output format
format="pdf"

# Initialize log file
> "$log_file"
cd "$input_directory" || exit

log() {
    local message="$1"
    local current_time=$(date +"%Y-%m-%d %H-%M-%S")
    echo "$current_time: $message" >> "$log_file"
}

log "начало выполнения конвертации файлов"

convert_file() {
    local file="$1"
    local error

    error=$(lowriter --headless --convert-to "$format" "$file" --outdir "$output_directory" 2>&1 >/dev/null)
    
    if [ -z "$error" ]; then
        log "файл $file успешно переконвертирован в $format"
        if [[ "$file" =~ \.docx$ ]]; then
            log "добавление файла $file в папку lr_doc"
            cp "$file" "$doc_directory"
        fi
    else
        log "ошибка конвертации файла $file"
        echo "$error" >> "$log_file"
    fi
}


for file in *.*; do
    echo "$file"
    convert_file "$file"
done

log "конвертация файлов завершена"
cd ..

log "создание архива"
zip -r lr_arch.zip */
log "архив создан"
