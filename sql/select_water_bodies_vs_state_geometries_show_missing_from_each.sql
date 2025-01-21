SELECT * FROM vt_water_body_txt where lakeid is null;
select * from vt_water_body_geo where lakeid is null;

select * from vt_water_body_geo wg
--join vt_water_body_txt wt on wt.objectid=wg.objectid
--join vt_water_body_txt wt on wt.wbid=wg.wbid
--join vt_water_body_txt wt on wt.lakeid=wg.lakeid
--join vt_water_body wb on wbtextid=wg.lakeid
where gisacres is not null;

select * from vt_water_body_txt where lakeid is null;
select * from vt_water_body_geo where lakeid is null;
select * from vt_water_body where wbtextid is null;

select wbtextid as wbtextids_in_water_bodies_not_in_state_geo, wbarea from vt_water_body_geo wg
right join vt_water_body wb on wb.wbtextid=wg.lakeid
where lakeid is null
order by wbtextid asc;

select lakeid as lakeids_in_state_geo_not_in_water_bodies, gisacres, wbid from vt_water_body_geo wg
left join vt_water_body wb on wb.wbtextid=wg.lakeid
where wbtextid is null
order by lakeid asc;

select wbtextid, wbofficialname, locationname as lw_locationname, exportname as lw_textid from vt_water_body
join vt_loon_locations on exportname=wbtextid
where wbtextid != upper(locationname)
order by wbtextid