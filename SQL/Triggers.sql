Drop trigger if exists deleteEvent_associatation on associated_with;
Drop Function if exists removeTask();

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





