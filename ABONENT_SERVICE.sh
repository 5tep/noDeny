SELECT 
    u.id AS ABONENT_ID, 
    gp.id AS REGION_ID, 
    p.id AS ID, 
    FROM_UNIXTIME(u.contract_date) AS BEGIN_TIME, 
    FROM_UNIXTIME(u.modify_time) AS END_TIME, 
    '' AS PARAMETER, 
    u.id AS INTERNAL_ID1, 
    u.id AS INTERNAL_ID2
INTO OUTFILE '/var/lib/mysql-files/ABONENT_SERVICE_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '\"'
LINES TERMINATED BY '\n'
WHERE u.id = 3034 AND gp.pack_grps like CONCAT('%,', u.grp, ',%')
    AND gp.id in (13,18)
	 AND p.id = u.paket;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u username -p%пароль% big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/ABONENT_SERVICE_* /path/to/your
rm -f /var/lib/mysql-files/query.sql
