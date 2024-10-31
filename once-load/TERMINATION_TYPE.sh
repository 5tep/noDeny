# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "ID;BEGIN_TIME;END_TIME;DESCRIPTION;NETWORK_TYPE;REGION_ID" > /home/ma43152/COPM/files/TERMINATION_TYPE_$current_date.txt
echo "1;2022-12-18 00:00:00;2049-12-31 23:59:59;Нормальное завершение;0;4" >> /home/ma43152/COPM/files/TERMINATION_TYPE_$current_date.txt
echo "2;2022-12-18 00:00:00;2049-12-31 23:59:59;Ошибка;0;4" >> /home/ma43152/COPM/files/TERMINATION_TYPE_$current_date.txt

