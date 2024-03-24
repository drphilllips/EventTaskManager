select Unique u.First_Name, u.Last_Name 
from users u, event_hosts eh, hosts h, events e, associated_with aw, event_features ef, 
satisfies s, tasks t
where u.userID = eh.userID and eh.userID = h.userID and h.eventID = e.eventID and e.eventID = aw.eventID and
aw.featureID = ef.featureID and ef.featureID = s.featureID and s.taskID = t.taskID and
t.duedate = TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD');

select t.Task_Name, t.DueDate, t.Description
from users u, event_hosts eh, hosts h, events e, associated_with aw, event_features ef, 
satisfies s, tasks t
where u.userID = eh.userID and eh.userID = h.userID and h.eventID = e.eventID and e.eventID = aw.eventID and
aw.featureID = ef.featureID and ef.featureID = s.featureID and s.taskID = t.taskID and
u.First_Name = 'Anne' and u.Last_Name = 'Lapsley' and t.completed_date_time is NULL;

Select e.event_name
from events e
where trunc(e.Start_Time_Date) = TO_TIMESTAMP('2024-03-24', 'YYYY-MM-DD');

select e.Start_Time_Date, e.End_Time_Date 
from events e, locations l
where e.locID = l.locID and l.location_name = 'Fuller Upper';

select u.First_Name, u.Last_Name, count(am.EventID)
from users u, admins a, administrates am, events e
Where u.UserID = a.UserID and a.UserID = am.UserID and am.eventID = e.eventID 
Group by u.First_Name, u.Last_Name;