# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "ISO_3166_APHA_2;ISO_3166_APHA_3;COUNTRY_CODE;NUMBER_PREFIX;AREA_CODE_LENGTH;MIN_NUMBER_LENGTH;MAX_NUMBER_LENGTH;UTC_MIN;UTC_MAX;COUNTRY_DEST;NETWORK_TYPE;CAPACITY_FROM;CAPACITY_TO;CAPACITY_SIZE;LOCATION;OPERATOR_NAME;BEGIN_TIME;END_TIME;MCC;MNC;STATUS;DESCRIPTION;OPERATOR_CODE;REGION_ID" > /path/to/your/PHONE_PLAN_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "RU;RUS;7;495;3;7;7;3;3;РОССИЯ;3;5003000;5003199;200;г.Москва, ул.Нижняя Красносельская, д.28а;АО Компания;2012-12-18 00:00:00;2099-12-31 23:59:59;250;;;;;88" >> /path/to/your/PHONE_PLAN_$current_date.txt
#