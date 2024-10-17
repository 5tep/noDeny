# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    u.id AS ID,
    '2022-01-01 00:00:00' AS BEGIN_TIME,  --  дата начала
    '2099-12-31 23:59:59' AS END_TIME,    --  дата окончания
    u.pack_name AS DESCRIPTION,        -- Описание
    '' AS MCC,                         -- Значение MCC
    '' AS MNC                           -- MNC не указан
INTO OUTFILE '/var/lib/mysql-files/REGIONS_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    user_grppack u
WHERE 
    u.id in (13,18);
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/REGIONS* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
