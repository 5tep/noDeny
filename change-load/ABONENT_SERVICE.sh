# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    u.id AS ABONENT_ID, 
    gp.id AS REGION_ID, 
    p.id AS ID, 
    FROM_UNIXTIME(u.modify_time) AS BEGIN_TIME, 
    '2099-12-31 23:59:59' AS END_TIME, 
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
	 AND p.id = u.paket
     AND FROM_UNIXTIME(u.modify_time) BETWEEN CURDATE() - INTERVAL 1 DAY AND CURDATE();
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u username -p%пароль% big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT_SERVICE_* /path/to/your
rm -f /var/lib/mysql-files/query.sql
