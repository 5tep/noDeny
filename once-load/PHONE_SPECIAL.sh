# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "PHONE_NUMBER;DESCRIPTION;BEGIN_TIME;END_TIME;IP_TYPE;IPV4;IPV6;REGION_ID" > /home/ma43152/COPM/files/PHONE_SPECIAL_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "6677;Контактный центр;2009-10-14 00:00:00;2099-12-31 23:59:59;;;;18" >> /home/ma43152/COPM/files/PHONE_SPECIAL_$current_date.txt
#   echo "7060;Контактный центр;2009-10-14 00:00:00;2099-12-31 23:59:59;;;;13" >> /home/ma43152/COPM/files/PHONE_SPECIAL_$current_date.txt
#