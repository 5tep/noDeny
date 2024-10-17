# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT DISTINCT 
    u.id AS ABONENT_ID,
    gp.id AS REGION_ID,
    1 AS ADDRESS_TYPE_ID,  -- Фиксированное значение
    1 AS ADDRESS_TYPE,     -- Фиксированное значение
    '' AS ZIP,             -- Пустое поле, значение не указано
    'Российская Федерация' AS COUNTRY,  -- Статическое значение для страны
    'Херсонская область' AS REGION,    -- Регион из таблицы улиц
    '' AS ZONE,            -- Пустое поле, значение не указано
    gp.pack_name AS CITY,  -- Статическое значение для города
    (SELECT s.name_street FROM p_street s WHERE s.street = dv_street.field_value) AS STREET,  -- Название улицы из таблицы p_street
    dv_building.field_value AS BUILDING,  -- Номер здания из таблицы dopvalues
    dv_build_sect.field_value AS BUILD_SECT,  -- Секция здания из таблицы dopvalues
    dv_apartment.field_value AS APARTMENT,  -- Номер квартиры из таблицы dopvalues
   -- CONCAT(', ', p.name_street, ', д. ', dv_building.field_value) AS UNSTRUCT_INFO,  -- Адрес как неструктурированное поле
    FROM_UNIXTIME(u.contract_date) AS BEGIN_TIME,  
    '2099-12-31 23:59:59' AS END_TIME,    -- Фиксированное значение
    '' AS INTERNAL_ID1,   -- Пустое поле
    '' AS INTERNAL_ID2    -- Пустое поле
INTO OUTFILE '/var/lib/mysql-files/ABONENT_ADDRESS_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    user_grppack gp,users u
 LEFT JOIN 
    dopvalues dv_street ON dv_street.dopfield_id = 5 and dv_street.parent_id = u.id
 LEFT JOIN 
     dopvalues dv_building ON dv_building.dopfield_id = 6 and dv_building.parent_id = u.id
 LEFT JOIN 
     dopvalues dv_build_sect ON dv_build_sect.dopfield_id = 7 and dv_build_sect.parent_id = u.id
 LEFT JOIN 
     dopvalues dv_apartment ON dv_apartment.dopfield_id = 8 and dv_apartment.parent_id = u.id
WHERE gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18)
    AND FROM_UNIXTIME(dv_street.time) BETWEEN CURDATE() - INTERVAL 1 DAY AND CURDATE()
;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT_ADDRESS* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
