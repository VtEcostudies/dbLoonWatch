--There are errors in the originally imported dataset received from VCE Loon Biologists, 'Official_Lake_List_VT_2023.csv'
--Find and fix those here.
--Also, with 2024 updates to the LoonWatch system to add water body polygons from VT-ANR, we find theirs to have errors.
--Find and fix those here.
--First, with VT-ANR polygons from vt_water_body_geo, remove column wbgeoborder
ALTER TABLE vt_water_body DROP COLUMN wbgeoborder;
--2023 Official Lake list has errors swapping some data between MILLER (STRFRD) and MILLER (ARLTON)
SELECT * FROM vt_water_body WHERE wbtextid LIKE 'MILLER%';
UPDATE vt_water_body SET 
	wbfullname='Miller Pond Arlington',
	wbtype='Pond'
WHERE wbtextid='MILLER (ARLTON)';
UPDATE vt_water_body SET 
	wbfullname='Miller Pond Strafford',
	wbtype='Lake (Artificial Control)'
WHERE wbtextid='MILLER (STRFRD)';
--Now match the 2 MILLERS in vt_water_body to the 2 MILLERS in vt_water_body_geo
--...and rename theM in vt_water_body_geo.
--To-Do: making changes to vt_water_body_geo is a problem for future updates from VT-ANR
SELECT * FROM vt_water_body_geo WHERE lakeid LIKE 'MILLER%';
SELECT * FROM vt_water_body_geo WHERE wbid='VT14-02L01';
SELECT * FROM vt_water_body_geo WHERE wbid='VT01-06L03';
UPDATE vt_water_body_geo SET lakeid='MILLER (STRFRD)' WHERE wbid='VT14-02L01';
UPDATE vt_water_body_geo SET lakeid='MILLER (ARLTON)' WHERE wbid='VT01-06L03';