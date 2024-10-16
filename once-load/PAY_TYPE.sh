# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "ID;BEGIN_TIME;END_TIME;DESCRIPTION;REGION_ID" > /path/to/your/PAY_TYPE_$current_date.txt
echo "1;2008-01-02 00:00:00;2099-12-31 23:59:59;Касса;13" >> /path/to/your/PAY_TYPE_$current_date.txt
echo "2;2008-01-02 00:00:00;2099-12-31 23:59:59;Касса;18" >> /path/to/your/PAY_TYPE_$current_date.txt