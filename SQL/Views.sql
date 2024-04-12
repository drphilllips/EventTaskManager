--Create different views for the web app

Drop VIEW if exists All_assigned_tasks;
Drop VIEW if exists All_completed_tasks;
Drop VIEW if exists All_Event_Features;
Drop VIEW if exists Hosts_sign_in;


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
    --    (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
    --    trunc(ast.assign_date_time) as assigned_date,
        to_char(t.completed_date_time, 'dd-MON-yyyy') as completed_on
        FROM tasks t Inner JOIN users u on u.userID = t.assigned_to_userid 
    --    Inner JOIN users u2 on u2.userID = ast.Assigned_to
        Inner Join associated_with aw on aw.taskid = t.taskid
		inner join events e on e.eventid = aw.eventid
        where t.task_name IS NOT NULL and t.completed_date_time is NOT NULL;
       
             
     
Create VIEW Hosts_sign_in AS
    select (u.first_name || ' ' || u.Last_Name) as Host_Name,
            e.event_name,
            to_char(ipa.sign_in, 'dd-MON-yyyy hh:mm AM') as sign_in,
            to_char(ipa.sign_out, 'dd-MON-yyyy hh:mm AM') as sign_out
    from users u natural join is_present_at ipa
    natural join events e ;