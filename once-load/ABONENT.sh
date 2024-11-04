# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    'ID', 'REGION_ID', 'CONTRACT_DATE', 'CONTRACT', 'ACTUAL_FROM', 'ACTUAL_TO', 'ABONENT_TYPE', 
    'NAME_INFO_TYPE', 'FAMILY_NAME', 'GIVEN_NAME', 'INITIAL_NAME', 'UNSTRUCT_NAME', 'BIRTH_DATE', 
    'IDENT_CARD_TYPE_ID', 'IDENT_CARD_TYPE', 'IDENT_CARD_SERIAL', 'IDENT_CARD_NUMBER', 
    'IDENT_CARD_DESCRIPTION', 'IDENT_CARD_UNSTRUCT', 'BANK', 'BANK_ACCOUNT', 'FULL_NAME', 'INN', 
    'CONTACT', 'PHONE_FAX', 'STATUS', 'ATTACH', 'DETACH', 'NETWORK_TYPE', 'INTERNAL_ID1', 
    'INTERNAL_ID2'
UNION ALL
SELECT DISTINCT
    u.id AS ID,
    4 AS REGION_ID, -- Статическое значение региона
    FROM_UNIXTIME(u.contract_date, '%Y-%m-%d %H:%i:%s') AS CONTRACT_DATE, -- Преобразование UNIX времени в читаемый формат
    u.id AS CONTRACT,
    FROM_UNIXTIME(u.contract_date, '%Y-%m-%d %H:%i:%s') AS ACTUAL_FROM, -- Дата заключения контракта
    '2049-12-31 23:59:59' AS ACTUAL_TO, -- Статическая дата окончания
    42 AS ABONENT_TYPE, -- Статическое значение типа абонента
    1 AS NAME_INFO_TYPE, -- Поле пустое
    '' AS FAMILY_NAME, -- Поле пустое
    '' AS GIVEN_NAME, -- Можно предположить, что FIO содержит полное имя
    '' AS INITIAL_NAME, -- Поле пустое
    u.fio AS UNSTRUCT_NAME, -- Используем FIO как неструктурированное имя
    '' AS BIRTH_DATE, -- Поле Дата рождения
    1 AS IDENT_CARD_TYPE_ID, -- Поле ИД типа документа
    CASE
    	WHEN COALESCE(dv_serial.field_value, '') = '' THEN 1
    	ELSE 0
    END AS IDENT_CARD_TYPE, -- Поле Тип документа
    COALESCE(dv_serial.field_value, '') AS IDENT_CARD_SERIAL, -- Поле серия паспорта
    COALESCE(dv_number.field_value, '') AS IDENT_CARD_NUMBER, -- Поле номер паспорта
    TRIM(REPLACE(REPLACE(REPLACE(COALESCE(dv_descript.field_value, ''), '\n', ' '), '\r', ' '), '\t', ' ')) AS IDENT_CARD_DESCRIPTION, -- Поле Кем, когда выдан
    CASE
    	WHEN COALESCE(dv_serial.field_value, '') = '' THEN 'данные отсутствуют'
    	ELSE ''
    END  AS IDENT_CARD_UNSTRUCT, -- Поле пустое
    '' AS BANK, -- Статическое значение банка
    '' AS BANK_ACCOUNT, -- Статическое значение банковского счета
    '' AS FULL_NAME, -- Используем FIO как полное имя
    '' AS INN, -- Поле пустое
    '' AS CONTACT, -- Поле пустое
    '' AS PHONE_FAX, -- Поле пустое
    0 AS STATUS, -- Статическое значение статуса
    FROM_UNIXTIME(u.modify_time, '%Y-%m-%d %H:%i:%s') AS ATTACH, -- Дата последнего изменения
    '2049-12-31 23:59:00' AS DETACH, -- Статическая дата отсоединения
    4 AS NETWORK_TYPE, -- Поле пустое
    u.id AS INTERNAL_ID1, -- Поле пустое
    u.id AS INTERNAL_ID2 -- Поле пустое
INTO OUTFILE '/var/lib/mysql-files/ABONENT_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    user_grppack gp, fullusers u
LEFT JOIN 
    dopvalues dv_serial ON dv_serial.dopfield_id = 11133 and dv_serial.parent_id = u.id
LEFT JOIN 
    dopvalues dv_number ON dv_number.dopfield_id = 11134 and dv_number.parent_id = u.id
LEFT JOIN 
    dopvalues dv_descript ON dv_descript.dopfield_id = 11135 and dv_descript.parent_id = u.id

WHERE gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18) AND u.contract_date > 694161103 AND u.contract_date < 2524545103;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
