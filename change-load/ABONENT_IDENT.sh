# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    u.id AS ABONENT_ID, 
    gp.id AS REGION_ID, -- Статическое значение региона
    '' AS IDENT_TYPE, -- Статическое значение идентификационного типа
    '' AS PHONE, -- Поле пустое
    '' AS INTERNAL_NUMBER, -- Поле пустое
    '' AS IMSI, -- Поле пустое
    '' AS IMEI, -- Поле пустое
    '' AS ICC, -- Поле пустое
    '' AS MIN, -- Поле пустое
    '' AS ESN, -- Поле пустое
    '' AS EQUIPMENT_TYPE, -- Поле пустое
    u.mac AS MAC, -- MAC-адрес пользователя, если он есть
    '' AS VPI, -- Поле пустое
    '' AS VCI, -- Поле пустое
    u.name AS LOGIN, -- Логин пользователя
    '' AS E_MAIL, -- Поле пустое
    '' AS PIN, -- Поле пустое
    '' AS USER_DOMAIN, -- Поле пустое
    '' AS RESERVED, -- Поле пустое
    '' AS ORIGINATOR_NAME, -- Поле пустое
    '' AS IP_TYPE, -- Поле пустое
    u.ip AS IPV4, -- Преобразование IP-адреса из формата INT в строку
    '' AS IPV6, -- Поле пустое
    '' AS IP_MASK_TYPE, -- Поле пустое
    '' AS IPV4_MASK, -- Поле пустое
    '' AS IPV6_MASK, -- Поле пустое
    '' AS IP_RANGE_START, -- Поле пустое
    '' AS IP_RANGE_END, -- Поле пустое
    u.id AS INTERNAL_ID1, -- Используем ID пользователя как INTERNAL_ID1
    u.id AS INTERNAL_ID2, -- Используем ID пользователя как INTERNAL_ID2
    FROM_UNIXTIME(u.contract_date, '%Y-%m-%d %H:%i:%s') AS BEGIN_TIME, -- Дата начала контракта
    '2049-12-12 23:59:00' AS END_TIME, -- Статическая дата окончания
    '' AS LINE_OBJECT, -- Поле пустое
    '' AS LINE_CROSS, -- Поле пустое
    '' AS LINE_BLOCK, -- Поле пустое
    '' AS LINE_PAIR, -- Поле пустое
    '' AS LINE_RESERVED, -- Поле пустое
    '' AS LOC_TYPE, -- Поле пустое
    '' AS LOC_LAC, -- Поле пустое
    '' AS LOC_CELL, -- Поле пустое
    '' AS LOC_TA, -- Поле пустое
    '' AS LOC_CELL_WIRELESS, -- Поле пустое
    '' AS LOC_MAC, -- Поле пустое
    '' AS LOC_LATITUDE, -- Поле пустое
    '' AS LOC_LONGITUDE, -- Поле пустое
    '' AS LOC_PROJECTION_TYPE, -- Поле пустое
    '' AS LOC_IP_TYPE, -- Поле пустое
    u.ip AS LOC_IPV4, -- Используем IP пользователя для LOC_IPV4
    '' AS LOC_IPV6, -- Поле пустое
    '' AS LOC_IP_PORT -- Поле пустое
INTO OUTFILE '/var/lib/mysql-files/ABONENT_IDENT_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    user_grppack gp, users u
WHERE gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18)
    AND FROM_UNIXTIME(u.modify_time) BETWEEN CURDATE() - INTERVAL 1 DAY AND CURDATE()
;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT_IDENT* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
