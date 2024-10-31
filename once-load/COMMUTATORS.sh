# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "SWITCH_ID;BEGIN_TIME;END_TIME;DESCRIPTION;NETWORK_TYPE;SWITCH_TYPE;ADDRESS_TYPE_ID;ADDRESS_TYPE;ZIP;COUNTRY;REGION;ZONE;CITY;STREET;BUILDING;BUILD_SECT;APARTMENT;UNSTRUCT_INFO;SWITCH_SIGN;REGION_ID" > /home/ma43152/COPM/files/IP_PLAN_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "Сеть для абонентов при отсутствии денег;0;0A010101;;0;FFFFFF00;;2008-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
#   echo "Белые динамические адреса ;0;5B8E9801;;0;FFFFFF00;;2008-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
#   echo "Белые статические адреса;0;2EE31A81;;0;FFFFFF80;;2008-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
#
