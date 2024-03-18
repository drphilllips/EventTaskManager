--Create different views for the web app

--Create a a view for assigned Tasks
CREATE VIEW All_Assigned_Tasks (assigned_tasks, USERS) AS
    SELECT (u.first_name || ' ' || u.Last_Name) as Assigned_To,
            ast.Name, ast.Description, Date(ast.Duedate)
    FROM USERS u Join Assigned_Tasks ast
    ON u.userID = ast.userID

