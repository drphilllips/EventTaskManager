DDrop trigger if exists deleteEvent_associatation on associated_with;
Drop trigger if exists removeEventOnComplete on events;
Drop Function if exists removeTask();
Drop Function if exists removeEvent();


create or replace function removeTask() returns trigger as $deleteEvent_associatation$
Begin
	delete from tasks where taskid = old.taskid;
Return New;
end;
$deleteEvent_associatation$
language plpgsql;

Create trigger deleteEvent_associatation 
after delete on associated_with
for each row
execute procedure removeTask();

create or replace function removeEvent() returns trigger as $removeEventOnComplete$
begin
	delete from events where current_timestamp > old.end_time_date;
return new;
end;
$removeEventOnComplete$
language plpgsql;

Create trigger removeEventOnComplete
before delete on events
for each row 
execute procedure removeEvent();



