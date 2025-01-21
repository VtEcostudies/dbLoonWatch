CREATE TABLE IF NOT EXISTS vt_water_body_txt
(
	objectid INTEGER,
	source TEXT,
	wbid TEXT,
	lakeid TEXT,
	EventType TEXT,
	GISAcres DECIMAL
);
-- to enable file permisssions to import, in File Explorer: 
-- >Properties>Security>Group or User Names>Edit>Group or User Names>Add>Enter Object Name>Everyone
COPY vt_water_body_txt FROM 
'C:\Users\jtloo\Documents\VCE\LoonWeb\dbLoonWatch\VT_ANR_Download\Lake_Pond_WBIDs_and_WBID_Segments.csv' 
DELIMITER ',' CSV HEADER;