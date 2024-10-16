# Получение текущей даты
current_date=$(date +%Y%m%d_%H%M)
current_table=$(date +x%Yx%mx%d --date='yesterday')
# Формирование MySQL-запроса с выводом в файл
echo "
SELECT
    (SELECT max(ug.id) from user_grppack ug, users u where ug.pack_grps like CONCAT('%,', u.grp, ',%') AND ug.id in (13,18)) AS REGION_ID,                        -- Статическое значение для REGION_ID
    mid AS VOIP_ID,                       -- Поле mid как VOIP_ID
    FROM_UNIXTIME(time) AS BEGIN_TIME,    -- Начальное время (конвертация Unix time)
    '' AS END_TIME,                         -- Конец времени (пустое, так как в таблице нет)
    INET_NTOA(ip) AS CLIENT_IPV4,         -- Преобразование IP из числа в IPv4
    '' AS CLIENT_IPV6,                      -- Клиентский IPv6 (пустое, так как нет данных)
    '' AS CLIENT_IP_PORT,               -- Порт клиента
    '' AS SERVER_IPV4,                      -- Серверный IPv4 (пустое)
    '' AS SERVER_IPV6,                      -- Серверный IPv6 (пустое)
    '' AS SERVER_IP_PORT,                   -- Серверный порт (пустое)
    '' AS PROTOCOL_CODE,               -- Протокол
    '' AS POINT_ID,                         -- Пустое поле
    '' AS SESSION_ID,                       -- Пустое поле
    '' AS CONFERENCE_ID,                    -- Пустое поле
    '' AS DURATION,                         -- Длительность (можно рассчитать, если есть данные о сессиях)
    '' AS ORIGINATOR_NAME,                  -- Пустое поле
    '' AS CALL_TYPE_ID,                     -- Пустое поле
    '' AS CALLING_ORIGINAL_NUMBER,          -- Пустое поле
    '' AS CALLING_TRANSLATED_NUMBER,        -- Пустое поле
    '' AS CALLING_E164_NUMBER,              -- Пустое поле
    '' AS CALLED_ORIGINAL_NUMBER,           -- Пустое поле
    '' AS CALLED_TRANSLATED_NUMBER,         -- Пустое поле
    '' AS CALLED_E164_NUMBER,               -- Пустое поле
    bytes AS IN_BYTES,                    -- Переданные байты (IN_BYTES)
    '' AS OUT_BYTES,                         -- OUT_BYTES отсутствуют, установим 0
    '' AS FAX,                              -- Пустое поле
    '' AS TERM_CAUSE,                       -- Пустое поле
    '' AS INBOUND_BUNCH,                 -- Статическое значение
    '' AS INBOUND_MAC,                      -- Пустое поле
    '' AS INBOUND_VPI,                      -- Пустое поле
    '' AS INBOUND_VCI,                      -- Пустое поле
    '' AS OUTBOUND_BUNCH,                   -- Пустое поле
    '' AS OUTBOUND_MAC,                     -- Пустое поле
    '' AS OUTBOUND_VPI,                     -- Пустое поле
    '' AS OUTBOUND_VCI,                     -- Пустое поле
    '' AS VOIP_PROTOCOL,                     -- Статическое значение
    '' AS SUPPLEMENT_SERVICE_ID,             -- Статическое значение
    mid AS ABONENT_ID,                    -- ID абонента
    '' AS NAT_IP4,                          -- Пустое поле
    '' AS NAT_IP6,                          -- Пустое поле
    '' AS NAT_PORT,                         -- Пустое поле
    '' AS LOC_TYPE,                          -- Статическое значение
    '' AS ML_LAC,                           -- Пустое поле
    '' AS ML_CELL,                          -- Пустое поле
    '' AS ML_TA,                            -- Пустое поле
    '' AS WL_CELL,                          -- Пустое поле
    '' AS WL_MAC,                           -- Пустое поле
    '' AS GL_LAT,                           -- Пустое поле
    '' AS GL_LONG,                          -- Пустое поле
    '' AS GL_PROJ_TYPE,                      -- Статическое значение
    '' AS LOC_IP_TYPE,                       -- Статическое значение
    '' AS LOC_IPV4,                         -- Пустое поле
    '' AS LOC_IPV6,                         -- Пустое поле
    '' AS LOC_IP_PORT,                      -- Пустое поле
    '' AS VOIP_EVENT,                        -- Статическое значение
    '' AS DATA_CONTENT_ID,                   -- Статическое значение
    '' AS GATEWAY_IP4,                      -- Пустое поле
    '' AS GATEWAY_IP6                       -- Пустое поле
INTO OUTFILE '/var/lib/mysql-files/CONNECTION_VOIP_$current_date.txt'
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY ''
LINES TERMINATED BY '\n'
FROM 
    $current_table;
" > /var/lib/mysql-files/query.sql

# Выполнение завроса в базе данных
mysql -u username -p%пароль% big_nodeny < /var/lib/mysql-files/query.sql

# Перенос файлов, подчищаем за собой
mv -f /var/lib/mysql-files/CONNECTION_VOIP* /path/to/your
rm -f /var/lib/mysql-files/query.sql
