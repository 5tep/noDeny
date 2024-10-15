# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT DISTINCT
    u.id AS ID,
    gp.id AS REGION_ID, -- Статическое значение региона
    FROM_UNIXTIME(u.contract_date, '%Y-%m-%d %H:%i:%s') AS CONTRACT_DATE, -- Преобразование UNIX времени в читаемый формат
    u.contract AS CONTRACT,
    FROM_UNIXTIME(u.contract_date, '%Y-%m-%d %H:%i:%s') AS ACTUAL_FROM, -- Дата заключения контракта
    '2099-12-31 23:59:59' AS ACTUAL_TO, -- Статическая дата окончания
    '' AS ABONENT_TYPE, -- Статическое значение типа абонента
    '' AS NAME_INFO_TYPE, -- Поле пустое
    '' AS FAMILY_NAME, -- Поле пустое
    u.fio AS GIVEN_NAME, -- Можно предположить, что FIO содержит полное имя
    '' AS INITIAL_NAME, -- Поле пустое
    u.fio AS UNSTRUCT_NAME, -- Используем FIO как неструктурированное имя
    '' AS BIRTH_DATE, -- Поле Дата рождения
    '' AS IDENT_CARD_TYPE_ID, -- Поле ИД типа документа
    '' AS IDENT_CARD_TYPE, -- Поле Тип документа
    dv_serial.field_value AS IDENT_CARD_SERIAL, -- Поле серия паспорта
    dv_number.field_value AS IDENT_CARD_NUMBER, -- Поле номер паспорта
    dv_descript.field_value AS IDENT_CARD_DESCRIPTION, -- Поле Кем, когда выдан
    CONCAT(dv_serial.field_value, ' ', dv_number.field_value, ' ', dv_descript.field_value) AS IDENT_CARD_UNSTRUCT, -- Поле пустое
    '' AS BANK, -- Статическое значение банка
    '' AS BANK_ACCOUNT, -- Статическое значение банковского счета
    u.fio AS FULL_NAME, -- Используем FIO как полное имя
    '' AS INN, -- Поле пустое
    '' AS CONTACT, -- Поле пустое
    '' AS PHONE_FAX, -- Поле пустое
    0 AS STATUS, -- Статическое значение статуса
    FROM_UNIXTIME(u.modify_time, '%Y-%m-%d %H:%i:%s') AS ATTACH, -- Дата последнего изменения
    '2099-12-31 23:59:59' AS DETACH, -- Статическая дата отсоединения
    '' AS NETWORK_TYPE, -- Поле пустое
    '' AS INTERNAL_ID1, -- Поле пустое
    '' AS INTERNAL_ID2 -- Поле пустое
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
    AND gp.id in (13,18);
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u username -p%пароль% big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT* /path/to/your
rm -f /var/lib/mysql-files/query.sql
