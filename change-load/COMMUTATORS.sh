# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    'SWITCH_ID', 
    'BEGIN_TIME',      
    'END_TIME',        
    'DESCRIPTION',                    
    'NETWORK_TYPE',                      
    'SWITCH_TYPE',                       
    'ADDRESS_TYPE_ID',                   
    'ADDRESS_TYPE',                      
    'ZIP',                                
    'COUNTRY',        
    'REGION',             
    'ZONE',              
    'CITY',                   
    'STREET',                     
    'BUILDING',                        
    'BUILD_SECT',                    
    'APARTMENT',                        
    'UNSTRUCT_INFO',                    
    'SWITCH_SIGN',                       
    'REGION_ID'                        
UNION ALL
SELECT 
    s.switch AS SWITCH_ID, 
    FROM_UNIXTIME(s.date) AS BEGIN_TIME,      -- Указанная дата начала
    '2099-12-31 23:59:59' AS END_TIME,        -- Указанная дата окончания
    s.name AS DESCRIPTION,                    -- Используем поле name для описания
    '' AS NETWORK_TYPE,                      
    '' AS SWITCH_TYPE,                       
    '' AS ADDRESS_TYPE_ID,                   
    '' AS ADDRESS_TYPE,                      
    '' AS ZIP,                                -- Пустое значение для ZIP
    'Российская Федерация' AS COUNTRY,        -- Статическое значение для страны
    'Херсонсткая область' AS REGION,             -- Статическое значение для региона
    '' AS ZONE,              -- Статическое значение для зоны
    '' AS CITY,                   -- Статическое значение для города
    '' AS STREET,                     -- Статическое значение для улицы
    '' AS BUILDING,                        -- Статическое значение для здания
    '' AS BUILD_SECT,                    -- Статическое значение для секции здания
    '' AS APARTMENT,                        -- Пустое значение для квартиры
    '' AS UNSTRUCT_INFO,                    -- Пустое значение для дополнительной информации
    '' AS SWITCH_SIGN,                       
    18 AS REGION_ID                        -- Статическое значение для региона
INTO OUTFILE '/var/lib/mysql-files/COMMUTATORS_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    p_switch s
    AND FROM_UNIXTIME(s.date) BETWEEN CURDATE() - INTERVAL 1 DAY AND CURDATE()
    ;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/COMMUTATORS_* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
