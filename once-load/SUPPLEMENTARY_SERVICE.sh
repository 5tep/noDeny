# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)

# Формирование MySQL-запроса с выводом в файл
echo "
SELECT 
    'ID' AS ID,
    'MNEMONIC' AS MNEMONIC,
    'BEGIN_TIME' AS BEGIN_TIME,
    'END_TIME' AS END_TIME,
    'DESCRIPTION' AS DESCRIPTION,
    'REGION_ID' AS REGION_ID
UNION ALL
SELECT 
    id AS ID,
    name AS MNEMONIC,
    '2008-01-02 00:00:00' AS BEGIN_TIME,
    '2049-12-31 23:59:59' AS END_TIME,
    name AS DESCRIPTION,
    4 AS REGION_ID
INTO OUTFILE '/var/lib/mysql-files/SUPPLEMENTARY_SERVICE_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    plans2
WHERE name != '';
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u asdf -ptD44vTG59d big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/SUPPLEMENTARY_SERVICE* /home/ma43152/COPM/files
rm -f /var/lib/mysql-files/query.sql
