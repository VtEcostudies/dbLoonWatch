SELECT * 
FROM vt_water_body wb
JOIN vt_water_body_geo wg ON wbtextid=lakeid
WHERE gisacres > 10 
AND lakeid NOT LIKE 'CHAMP%';

SELECT wg.*
FROM vt_water_body wb
right JOIN vt_water_body_geo wg ON wbtextid=wg.lakeid
WHERE gisacres > 10 
AND lakeid NOT LIKE 'CHAMP%'
AND wbtextid IS NULL;

SELECT * 
FROM vt_water_body wb
JOIN vt_water_body_geo wg ON wbtextid LIKE lakeid || '%'
WHERE gisacres > 10 
AND lakeid NOT LIKE 'CHAMP%';

SELECT * 
FROM vt_water_body wb
JOIN vt_water_body_geo wg ON lakeid LIKE wbtextid || '%'
WHERE gisacres > 10 
AND lakeid NOT LIKE 'CHAMP%';
