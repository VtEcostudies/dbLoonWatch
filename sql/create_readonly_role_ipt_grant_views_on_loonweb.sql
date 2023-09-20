select * from loonwatch_sampling_event;
select * from loonwatch_sampling_occurrence;

CREATE ROLE ipt WITH LOGIN PASSWORD 'readonlyaccess';
GRANT CONNECT ON DATABASE loonweb TO ipt;
GRANT USAGE ON SCHEMA public TO ipt;
GRANT SELECT ON loonwatch_sampling_event TO ipt;
GRANT SELECT ON loonwatch_sampling_occurrence TO ipt;

--test for uniqueness
select "eventID", count("eventID") from loonwatch_sampling_event
group by "eventID"
having count("eventID")>1
UNION
select "occurrenceID", count("occurrenceID") from loonwatch_sampling_occurrence
group by "occurrenceID"
having count("occurrenceID")>1;
