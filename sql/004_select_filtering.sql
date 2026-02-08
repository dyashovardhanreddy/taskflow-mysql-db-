use taskflow;

-- Q1 List workspaces for a user
select w.name as workspace_name,
		w.id as workspace_id,
        wm.role,
        wm.joined_at
from workspace_members wm
join workspaces w on w.id = wm.workspace_id 
where wm.user_id = ?
order by wm.joined_at desc;



-- Q2 List projects in a workspace
select 
	p.id as project_id,
    p.name as project_name,
    p.created_by,
    p.created_at
from workspaces w
join projects p 
on w.id = p.workspace_id
where w.id = ?
order by p.created_at desc;

-- Q3 List tasks for a project

select 
	id as task_id,
    title,
    status,
    priority,
    assignee_id,
    due_date,
    updated_at
from tasks
where project_id = ?
order by updated_at desc;

-- Q4 List tasks assigned to a user

select 
	id as task_id,
    title,
    status,
    priority,
    project_id, 
    due_date
from tasks
where assignee_id = ?
and status != 'done'
order by due_date;	


--- Q5 List overdue tasks

select 
	id as task_id,
    title,
    project_id,
    assignee_id,
    due_date
from tasks
where due_date < now()
and status != 'done'
order by due_date;


--- Q6  Filter tasks by status within a project

select
	id as task_id,
    title,
    priority,
    assignee_id,
    due_date
from tasks
where project_id = ?
and status = 'blocked'
order by priority desc;


-- Q7 High priority tasks in a workspace

select
	t.id as task_id,
    t.title,
    t.priority,
    t.status,
    t.project_id
from tasks t
join projects p
on t.project_id = p.id
where p.workspace_id = ?
and t.priority in ('urgent', 'high')
and t.status != 'done';


--- Q8 Pagination query

select 
	id as task_id,
    title,
    status,
    priority,
    project_id, 
    due_date
from tasks
where assignee_id = ?
and status != 'done'
order by due_date
limit 3
offset 1;