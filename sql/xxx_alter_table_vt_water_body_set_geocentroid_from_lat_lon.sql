/*
  NOTE: this should be obsolete with the addtionof vt_water_body_geo, which contains accurate polygons of water bodies.
  W
*/
update vt_water_body set wbgeocentroid=ST_SetSRID(ST_MakePoint(wbcenterlongitude,wbcenterlatitude),4326);

update vt_water_body 
	set wbgeocentroid=ST_PointFromText('POINT(' || wbcenterlongitude::text || ' ' || wbcenterlatitude::text || ')', 4326);

SELECT wbcenterlatitude, wbcenterlongitude
, ST_PointFromText('POINT(' || wbcenterlongitude::text || ' ' || wbcenterlatitude::text || ')', 4326) 
FROM vt_water_body;

select wbgeocentroid,* from vt_water_body;
