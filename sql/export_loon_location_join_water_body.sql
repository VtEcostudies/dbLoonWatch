--\copy (select * from vt_loon_locations join vt_water_body on wbTextId=waterBodyId) to 'C:/Users/jtloo/Documents/VCE/LoonWeb/dbLoonWatch/csv_export/db_loon_location.csv' csv header

copy (select * from vt_loon_locations join vt_water_body on wbTextId=waterBodyId) 
to 'C:/Users/jtloo/Documents/VCE/LoonWeb/dbLoonWatch/csv_export/db_loon_location.csv' csv header
