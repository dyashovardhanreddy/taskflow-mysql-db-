use taskflow;


--- Transaction: create project + tasks

start transaction;

insert into projects(workspace_id, name, created_by) values(1, 'Data Platform Upgrade', 1);

SET @project_id := LAST_INSERT_ID();

insert into tasks(project_id, title, status, priority, created_by, assignee_id, due_date) 
	values(@project_id, 'Design data models', 'todo', 'high', 1, 2, NOW() + INTERVAL 10 DAY);
    
insert into tasks(project_id, title, status, priority, created_by, assignee_id, due_date) 
	values(@project_id, 'Build ingestion pipeline', 'todo', 'urgent', 1, 3, NOW() + INTERVAL 20 DAY);
    
commit;

--- Transaction: rollback on failure

START TRANSACTION;

INSERT INTO projects(workspace_id, name, created_by)
VALUES (1, 'TMF API Endpoint', 2);

SET @project_id := LAST_INSERT_ID();

-- force failure: created_by = 999 (FK fail)
INSERT INTO tasks(project_id, title, status, priority, created_by, assignee_id, due_date)
VALUES (@project_id, 'Created Order Endpoint', 'todo', 'medium', 999, 2, NOW() + INTERVAL 10 DAY);

ROLLBACK;

--- Transaction: multiple updates

start transaction;

update tasks set status = 'in_progress' where id = 1;

update tasks set status = 'done' where id = 2;

commit;