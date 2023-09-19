select * from loonwatch_sampling_event;
select * from loonwatch_sampling_occurrence;

REVOKE ALL PRIVILEGES ON loonwatch_sampling_observation FROM ipt;
DROP VIEW IF EXISTS loonwatch_sampling_observation;

CREATE ROLE ipt WITH LOGIN PASSWORD 'readonlyaccess';
GRANT CONNECT ON DATABASE loonweb TO ipt;
GRANT USAGE ON SCHEMA public TO ipt;
GRANT SELECT ON loonwatch_sampling_event TO ipt;
GRANT SELECT ON loonwatch_sampling_occurrence TO ipt;

select "eventID", count("eventID") from loonwatch_sampling_event
group by "eventID"
having count("eventID")>1;