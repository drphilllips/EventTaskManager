Drop VIEW if exists All_assigned_tasks;
Drop VIEW if exists All_completed_tasks;
Drop View IF EXISTS All_Active_Events;
Drop View IF EXISTS All_Pending_Events;

--View all assigned tasks
Create VIEW All_assigned_tasks AS
    SELECT (u.first_name || ' ' || u.Last_Name) as Assigned_By,
    t.task_name,
    e.event_name,
    (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
    to_char(t.assigned_date_time, 'dd-MON-yyyy') as assigned_on,
    to_char(t.duedate, 'dd-MON-yyyy') as due_date
    FROM tasks t INNER JOIN users u on u.userid = t.assigned_by_userid  
    Inner JOIN users u2 on u2.userID = t.assigned_to_userid
	Inner Join associated_with aw on aw.taskid = t.taskid
	inner join events e on e.eventid = aw.eventid
    where t.task_name IS NOT NULL and t.completed_date_time is NULL;

--view all completed taks    
Create VIEW All_completed_Tasks AS
    SELECT (u.first_name || ' ' || u.Last_Name) as Completed_by,
        t.task_name,
        e.event_name,
        to_char(t.completed_date_time, 'dd-MON-yyyy') as completed_on
        FROM tasks t Inner JOIN users u on u.userID = t.assigned_to_userid 
        Inner Join associated_with aw on aw.taskid = t.taskid
		inner join events e on e.eventid = aw.eventid
        where t.task_name IS NOT NULL and t.completed_date_time is NOT NULL;
                    

Create View All_Active_Events AS
	select e.eventid, e.event_name, 
			e.attendees_count, e.event_status,
			to_char(e.start_time_date, 'mm-dd-yyyy') as start_Date,
			to_char(e.start_time_date, 'HH24:mi AM') as start_time,
			to_char(e.end_time_date, 'mm-dd-yyyy') as end_Date,
			to_char(e.end_time_date, 'HH24:mi AM') as end_time,
			l.location_name as location,
			e.description
			from events e inner join locations l on l.locid = e.locid
			where e.event_status = 'active'
			Order by start_Date, start_time;
			
Create View All_Pending_Events AS
	select e.eventid, e.event_name, 
			e.attendees_count, e.event_status,
			to_char(e.start_time_date, 'mm-dd-yyyy') as start_Date,
			to_char(e.start_time_date, 'HH24:mi AM') as start_time,
			to_char(e.end_time_date, 'mm-dd-yyyy') as end_Date,
			to_char(e.end_time_date, 'HH24:mi AM') as end_time,
			l.location_name as location,
			e.description
			from events e inner join locations l on l.locid = e.locid
			where e.event_status = 'pending'
			Order by start_Date, start_time;
			
