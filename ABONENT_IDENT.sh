# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    u.id AS ABONENT_ID, 
    28 AS REGION_ID, -- Статическое значение региона
    5 AS IDENT_TYPE, -- Статическое значение идентификационного типа
    NULL AS PHONE, -- Поле пустое
    NULL AS INTERNAL_NUMBER, -- Поле пустое
    NULL AS IMSI, -- Поле пустое
    NULL AS IMEI, -- Поле пустое
    NULL AS ICC, -- Поле пустое
    NULL AS MIN, -- Поле пустое
    NULL AS ESN, -- Поле пустое
    NULL AS EQUIPMENT_TYPE, -- Поле пустое
    u.mac AS MAC, -- MAC-адрес пользователя, если он есть
    NULL AS VPI, -- Поле пустое
    NULL AS VCI, -- Поле пустое
    u.name AS LOGIN, -- Логин пользователя
    NULL AS E_MAIL, -- Поле пустое
    NULL AS PIN, -- Поле пустое
    NULL AS USER_DOMAIN, -- Поле пустое
    NULL AS RESERVED, -- Поле пустое
    NULL AS ORIGINATOR_NAME, -- Поле пустое
    NULL AS IP_TYPE, -- Поле пустое
    INET_NTOA(u.ip) AS IPV4, -- Преобразование IP-адреса из формата INT в строку
    NULL AS IPV6, -- Поле пустое
    NULL AS IP_MASK_TYPE, -- Поле пустое
    NULL AS IPV4_MASK, -- Поле пустое
    NULL AS IPV6_MASK, -- Поле пустое
    NULL AS IP_RANGE_START, -- Поле пустое
    NULL AS IP_RANGE_END, -- Поле пустое
    u.id AS INTERNAL_ID1, -- Используем ID пользователя как INTERNAL_ID1
    u.id AS INTERNAL_ID2, -- Используем ID пользователя как INTERNAL_ID2
    FROM_UNIXTIME(u.contract_date, '%Y-%m-%d %H:%i:%s') AS BEGIN_TIME, -- Дата начала контракта
    '2049-12-12 23:59:00' AS END_TIME, -- Статическая дата окончания
    NULL AS LINE_OBJECT, -- Поле пустое
    NULL AS LINE_CROSS, -- Поле пустое
    NULL AS LINE_BLOCK, -- Поле пустое
    NULL AS LINE_PAIR, -- Поле пустое
    NULL AS LINE_RESERVED, -- Поле пустое
    NULL AS LOC_TYPE, -- Поле пустое
    NULL AS LOC_LAC, -- Поле пустое
    NULL AS LOC_CELL, -- Поле пустое
    NULL AS LOC_TA, -- Поле пустое
    NULL AS LOC_CELL_WIRELESS, -- Поле пустое
    NULL AS LOC_MAC, -- Поле пустое
    NULL AS LOC_LATITUDE, -- Поле пустое
    NULL AS LOC_LONGITUDE, -- Поле пустое
    NULL AS LOC_PROJECTION_TYPE, -- Поле пустое
    NULL AS LOC_IP_TYPE, -- Поле пустое
    INET_NTOA(u.ip) AS LOC_IPV4, -- Используем IP пользователя для LOC_IPV4
    NULL AS LOC_IPV6, -- Поле пустое
    NULL AS LOC_IP_PORT -- Поле пустое
INTO OUTFILE '/var/lib/mysql-files/ABONENT_IDENT_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    user_grppack gp, users u
WHERE gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18)
;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u username -p%пароль% big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT_IDENT* /path/to/your
rm -f /var/lib/mysql-files/query.sql
