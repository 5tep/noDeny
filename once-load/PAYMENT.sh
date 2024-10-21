# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    1 AS PAYMENT_TYPE,  -- Задано статически
    1 AS PAY_TYPE_ID,
    FROM_UNIXTIME(time, '%Y-%m-%d 00:00:00') AS PAYMENT_DATE,
    p.cash AS AMOUNT,
    '' AS AMOUNT_CURRENCY,  -- Пустое поле
    '' AS PHONE_NUMBER,  -- Информация о номере телефона отсутствует в этой таблице
    p.mid AS ACCOUNT,  -- Пример форматирования номера счета
    '' AS INTERNAL_ID1,
    '' AS INTERNAL_ID2,
    '' AS BANK_ACCOUNT,  -- Пустое поле
    '' AS BANK_NAME,  -- Пустое поле
    '' AS EXPRESS_CARD_NUMBER,  -- Пустое поле
    '' AS TERMINAL_ID,  -- Пустое поле
    '' AS TERMINAL_NUMBER,  -- Пустое поле
    '' AS LATITUDE,  -- Пустое поле
    '' AS LONGITUDE,  -- Пустое поле
    '' AS PROJECTION_TYPE,  -- Пустое поле
    '' AS CENTER_ID,  -- Пустое поле
    '' AS DONATED_PHONE_NUMBER,  -- Пустое поле
    '' AS DONATED_ACCOUNT,  -- Пустое поле
    '' AS DONATED_INTERNAL_ID1,  -- Пустое поле
    '' AS DONATED_INTERNAL_ID2,  -- Пустое поле
    '' AS CARD_NUMBER,  -- Пустое поле
    '' AS PAY_PARAMS,  -- Пустое поле
    '' AS PERSON_RECIEVED,  -- Пустое поле
    '' AS BANK_DIVISION_NAME,  -- Пустое поле
    '' AS BANK_CARD_ID,  -- Пустое поле
    '' AS ADDRESS_TYPE_ID,  -- Пустое поле
    '' AS ADDRESS_TYPE,  -- Пустое поле
    '' AS ZIP,  -- Пустое поле
    'Российская Федерация' AS COUNTRY,  -- Пример статического значения
    '' AS REGION,  -- Пустое поле
    '' AS ZONE,  -- Пустое поле
    '' AS CITY,  -- Пустое поле
    '' AS STREET,  -- Пустое поле
    '' AS BUILDING,  -- Пустое поле
    '' AS BUILD_SECT,  -- Пустое поле
    '' AS APARTMENT,  -- Пустое поле
    '' AS UNSTRUCT_INFO,  -- Пустое поле
    gp.id AS REGION_ID  -- Пример статического значения
INTO OUTFILE '/var/lib/mysql-files/PAYMENT_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    pays p, users u, user_grppack gp
WHERE p.mid = u.id AND gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18) and p.mid NOT IN (0,1) and type = 10 AND p.category = 600;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/PAYMENT* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
