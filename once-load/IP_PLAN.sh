# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "DESCRIPTION;IP_TYPE;IPV4;IPV6;IP_MASK_TYPE;IPV4_MASK;IPV6_MASK;BEGIN_TIME;END_TIME;REGION_ID" > /path/to/your/IP_PLAN_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "Сеть для абонентов при отсутствии денег;0;0A010101;;0;FFFFFF00;;2008-01-02 00:00:00;2049-12-31 23:59:59;18" >> /path/to/your/IP_PLAN_$current_date.txt
#   echo "Белые динамические адреса ;0;5B8E9801;;0;FFFFFF00;;2008-01-02 00:00:00;2049-12-31 23:59:59;18" >> /path/to/your/IP_PLAN_$current_date.txt
#   echo "Белые статические адреса;0;2EE31A81;;0;FFFFFF80;;2008-01-02 00:00:00;2049-12-31 23:59:59;18" >> /path/to/your/IP_PLAN_$current_date.txt
#