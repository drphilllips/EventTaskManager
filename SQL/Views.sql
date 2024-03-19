--Create different views for the web app

Drop VIEW All_assigned_tasks;

Create VIEW All_assigned_tasks AS

    SELECT (u.first_name || ' ' || u.Last_Name) as Assigned_By,
    ast.task_name,
    e.event_name,
    trunc(ast.assign_date_time) as assigned_date,
    (u2.first_name || ' ' || u2.Last_Name) as Assigned_To,
    trunc(ast.duedate) as due_date
    FROM assigned_tasks ast Inner JOIN users u on u.userID = ast.userID 
    Left JOIN users u2 on u2.userID = ast.Assigned_to
    left JOIN satisfies s On s.taskid = ast.taskid
    left JOIN event_features ef on ef.featureid = s.featureid
    left JOIN associated_with aw on aw.featureid = ef.featureid
    left JOIN events e on e.eventid = aw.eventid;
