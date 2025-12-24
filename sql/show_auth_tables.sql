select t.table_name
from information_schema.tables t
where t.table_schema = 'auth'  -- put schema name here

order by t.table_name;