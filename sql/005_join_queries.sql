use taskflow;

--- Task detail view
select 
	t.id as task_id,
    t.title,
    t.description,
    t.status,
    t.priority,
    t.due_date,
    p.name as project_name,
    w.name as workspace_name,
    u_created.id as created_by_user_id,
    u_created.full_name as created_by_name,
    u_assignee.id as assignee_user_id,
    u_assignee.full_name as assignee_name
from tasks t
join projects p on t.project_id = p.id
join workspaces w on p.workspace_id = w.id
join users  u_created on u_created.id = t.created_by
left join users  u_assignee on u_assignee.id = t.assignee_id
where t.id = ?;

--- Task detail view

select 
	p.id as project_id,
    p.name as project_name,
    count(t.id) as number_of_tasks,
    sum(case when t.status = 'todo' then 1 else 0 end) as todo_tasks,
    sum(case when t.status = 'in_progress' then 1 else 0 end) as in_progress_tasks,
    sum(case when t.status = 'blocked' then 1 else 0 end) as blocked_tasks,
    sum(case when t.status = 'done' then 1 else 0 end) as done_tasks
from workspaces w
join projects p on w.id = p.workspace_id
left join tasks t on t.project_id = p.id
where w.id = ?
group by p.id,p.name;

--- Workspace members list

select 
	u.id as user_id,
    u.full_name as full_name,
    u.email,
    w.role,
    w.joined_at
from workspace_members w
join users u
	on u.id = w.user_id
where w.workspace_id = ?
order by w.role, w.joined_at;


--- My work overview


select 
	t.id as task_id,
    t.title as task_title,
    p.name as project_name,
    w.name as workspace_name,
    t.status,
    t.priority,
    t.due_date
from tasks t
join projects p
	on t.project_id = p.id
join workspaces w
	on w.id = p.workspace_id
where t.assignee_id = ? and t.status != 'done'
    


