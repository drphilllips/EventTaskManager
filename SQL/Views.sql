--Create different views for the web app

Drop VIEW All_assigned_tasks;
Drop VIEW All_completed_tasks;
Drop VIEW All_Event_Features;
Drop VIEW Hosts_sign_in;

--View all assigned tasks
Create VIEW All_assigned_tasks AS
    SELECT (u.first_name || ' ' || u.Last_Name) as Assigned_By,
    ast.task_name,
    e.event_name,
    (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
    trunc(ast.assign_date_time) as assigned_date,
    trunc(ast.duedate) as due_date
    FROM assigned_tasks ast NATURAL JOIN users u  
    Left JOIN users u2 on u2.userID = ast.Assigned_to
    left JOIN satisfies s On s.taskid = ast.taskid
    left JOIN event_features ef on ef.featureid = s.featureid
    left JOIN associated_with aw on aw.featureid = ef.featureid
    left JOIN events e on e.eventid = aw.eventid;

--view all completed taks    
Create VIEW All_completed_Tasks AS
    SELECT (u.first_name || ' ' || u.Last_Name) as Completed_by,
        c.task_name,
        e.event_name,
    --    (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
    --    trunc(ast.assign_date_time) as assigned_date,
        trunc(c.completed_date_time) as completed_on
        FROM completed_tasks c Inner JOIN users u on u.userID = c.userID 
    --    Left JOIN users u2 on u2.userID = ast.Assigned_to
        left JOIN satisfies s On s.taskid = c.taskid
        left JOIN event_features ef on ef.featureid = s.featureid
        left JOIN associated_with aw on aw.featureid = ef.featureid
        left JOIN events e on e.eventid = aw.eventid;
        
        
 --View showing all features associated with an event
 Create VIEW All_Event_Features AS
     select e.event_name, ef.feature_name
     from event_features ef 
     left join associated_with aw on aw.featureid = ef.featureid
     left JOIN events e on aw.eventid = e.eventid;
     

     
Create VIEW Hosts_sign_in AS
    select (u.first_name || ' ' || u.Last_Name) as Host_Name,
            e.event_name,
            to_char(ipa.sign_in, 'dd-MON-yyyy hh:mm AM') as sign_in,
            to_char(ipa.sign_out, 'dd-MON-yyyy hh:mm AM') as sign_out
    from users u natural join is_present_at ipa
    natural join events e ;

        
