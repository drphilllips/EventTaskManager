Drop TRIGGER Completed_Tasks;


--When a Task is Complete, remove the corresponding task from the Assigned 
--Tasks Table
CREATE OR REPLACE TRIGGER Completed_Tasks
AFTER INSERT ON Completed_Tasks
FOR EACH ROW
BEGIN
    Delete From assigned_tasks where taskid = :New.taskid;  
END;


