use taskflow;

--- Update task status
update tasks
set status = 'in_progress'
where id = 3;

select * from tasks where id = 3;

update tasks
set status = 'done'
where id = 3;

select * from tasks where id = 3;


--- Reassign a task

update tasks
set assignee_id = 2
where id = 15;

select * from tasks where id = 15;

update tasks
set assignee_id = NULL
where id = 15;

select * from tasks where id = 15;


--- Update due date

update tasks
set due_date = '2026-02-15 09:00:00'
where id = 15;

select * from tasks where id = 15;

update tasks
set due_date = NULL
where id = 15;

select * from tasks where id = 15;

--- Delete a task

delete from tasks where id = 15;

select * from tasks where id = 15;

--- Delete a project (CASCADE check)

delete from projects where id = 4;

select * from tasks;

--- Delete a project (CASCADE check)
--- Test A: SET NULL

delete from users where id = 5;

select * from tasks;

delete from users where id = 2;