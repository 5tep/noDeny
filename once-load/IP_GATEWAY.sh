# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "GATE_ID;IP_TYPE;IPV4;IPV6;IP_PORT;REGION_ID" > /path/to/your/IP_GATEWAY_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "5;0;0A000501;;;18" >> /path/to/your/IP_GATEWAY_$current_date.txt
#   echo "1154;0;0A000502;;;18" >> /path/to/your/IP_GATEWAY_$current_date.txt
#   echo "1905;0;0A000503;;;28" >> /path/to/your/IP_GATEWAY_$current_date.txt
#