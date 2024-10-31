# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    'ABONENT_ID', 
    'REGION_ID', 
    'ID', 
    'BEGIN_TIME', 
    'END_TIME', 
    'PARAMETER', 
    'INTERNAL_ID1', 
    'INTERNAL_ID2'
UNION ALL
SELECT 
    u.id AS ABONENT_ID, 
    4 AS REGION_ID, 
    p.id AS ID, 
    FROM_UNIXTIME(u.modify_time) AS BEGIN_TIME, 
    '2049-12-31 23:59:59' AS END_TIME, 
    '' AS PARAMETER, 
    u.id AS INTERNAL_ID1, 
    u.id AS INTERNAL_ID2
INTO OUTFILE '/var/lib/mysql-files/ABONENT_SERVICE_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
FROM users u, user_grppack gp, plans2 p
WHERE gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18)
	AND p.id = u.paket;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT_SERVICE_* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
