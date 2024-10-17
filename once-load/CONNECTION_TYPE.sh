# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "TYPE_ID;BEGIN_TIME;END_TIME;DESCRIPTION;DESCRIPTION_RU;DESCRIPTION_SHORT;IN_OUT_DIRECTION;IS_MOBILE;REGION_ID" > /home/ma43152/COPM/files/CONNECTION_TYPE_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "1;2022-12-18 00:00:00;2099-12-31 23:59:59;Intra-office;Внутренние вызовы;;;0;13" >> /home/ma43152/COPM/files/CONNECTION_TYPE_$current_date.txt
#   echo "2;2012-12-18 00:00:00;2099-12-31 23:59:59;Incoming to office;Входящие вызова;;;0;13" >> /home/ma43152/COPM/files/CONNECTION_TYPE_$current_date.txt
#   echo "3;2022-12-18 00:00:00;2099-12-31 23:59:59;Intra-office;Внутренние вызовы;;;0;18" >> /home/ma43152/COPM/files/CONNECTION_TYPE_$current_date.txt
#   echo "4;2012-12-18 00:00:00;2099-12-31 23:59:59;Incoming to office;Входящие вызова;;;0;18" >> /home/ma43152/COPM/files/CONNECTION_TYPE_$current_date.txt
#

