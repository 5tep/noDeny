# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование пустые данные в файл
echo "GATE_ID;BEGIN_TIME;END_TIME;DESCRIPTION;GATE_TYPE;ADDRESS_TYPE_ID;ADDRESS_TYPE;ZIP;COUNTRY;REGION;ZONE;CITY;STREET;BUILDING;BUILD_SECT;APARTMENT;UNSTRUCT_INFO;REGION_ID" > /path/to/your/GATEWAYS_$current_date.txt


#
#
#   В таблицах данных нет, можно заполнить вручную по примеру ниже:
#       
#   echo "5;2022-10-01 00:00:00;2099-12-31 23:59:59;CiscoISG: ASR-Firefly-ID18 [10.0.5.1] ;7;3;0;;Российская Федерация;Амурская область;Центральный район;Благовещенск;Калинина;103;103/1;;;18" >> /path/to/your/GATEWAYS_$current_date.txt
#