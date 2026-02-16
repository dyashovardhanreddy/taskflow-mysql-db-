use taskflow;

--- GET /users/:id/workspaces

select
	w.id as workspace_id,
    w.name as workspace_name,
    wm.role,
    wm.joined_at
from workspaces w
join workspace_members wm
	on w.id = wm.workspace_id
where wm.user_id  = 4;


--- GET /workspaces/:id/projects

select 
	p.id as project_id,
    p.name as project_name,
    p.created_at,
    u.full_name as created_by
from projects p
join users u
	on p.created_by = u.id
where p.workspace_id = 2;


--- GET /projects/:id/tasks

select
	t.id as task_id,
    t.title,
    t.status,
    t.priority,
    u.full_name as assignee_name,
    t.due_date
from tasks t
left join users u
	on t.assignee_id = u.id
where t.project_id = 3;


--- GET /users/:id/tasks

select 
	t.id as task_id,
    t.title,
    t.status,
    t.priority,
    p.name as project_name,
    w.name as workspace_name,
    t.due_date
from tasks t
left join projects p
	on p.id = t.project_id
left join workspaces w
	on p.workspace_id = w.id
where t.assignee_id = 3 
	and status != 'done'
order by due_date is NULL ASC;


--- GET /workspaces/:id/tasks?priority=high,urgent

select 
	t.id as task_id,
    t.title,
    t.status,
    t.priority,
    p.name as project_name
from tasks t
left join projects p
	on t.project_id = p.id
where p.workspace_id = 1
	and t.status != 'done'
    and t.priority in ('high','urgent');
    
--- GET /workspaces/:id/overdue

select 
	t.id as task_id,
    t.title,
    t.status,
    u.full_name as assignee_name,
    t.due_date,
    p.name as project_name
from tasks t
left join projects p
	on t.project_id = p.id
left join users u
	on u.id = t.assignee_id
where p.workspace_id = 1
	and t.status != 'done'
    and t.due_date < NOW();
    
    
--- GET /projects/:id/summary

select
	count(*) as total_tasks,
    sum(case when status = 'done' then 1 else 0 end) as done_tasks,
    sum(case when status != 'done' then 1 else 0 end) as active_tasks,
    (100.0 * sum(case when status = 'done' then 1 else 0 end) / nullif(count(id), 0)) as completion_percentage
from tasks
where project_id = 5
group by project_id;

--- GET /workspaces/:id/dashboard

select
	count(distinct p.id) as total_projects,
    count(t.id) as total_tasks,
    sum(case when t.due_date < NOW() and t.status != 'done' then 1 else 0 end) as overdue_tasks,
    sum(case when t.status != 'done' then 1 else 0 end) as active_tasks
from workspaces w
left join projects p
	on p.workspace_id = w.id
left join tasks t
	on t.project_id = p.id
where w.id = 1;