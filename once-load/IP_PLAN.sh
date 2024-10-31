# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "DESCRIPTION;IP_TYPE;IPV4;IPV6;IP_MASK_TYPE;IPV4_MASK;IPV6_MASK;BEGIN_TIME;END_TIME;REGION_ID" > /home/ma43152/COPM/files/IP_PLAN_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#                                                  
   echo "Сеть для абонентов при отсутствии денег;0;AC100A01;;0;FFFFFF00;;2024-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
   echo "Внутренняя сеть для абонентов;0;0A000001;;0;FF000000;;2024-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
   echo "Белые статические адреса;0;1F28D201;;0;FFFFFF00;;2024-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
   echo "Старая сеть абонентов;0;5F2FAC01;;0;FFFFFF00;;2024-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
   echo "Сеть коммутаторов;0;AC100201;;0;FFFFFF00;;2024-01-02 00:00:00;2049-12-31 23:59:00;4" >> /home/ma43152/COPM/files/IP_PLAN_$current_date.txt
#

