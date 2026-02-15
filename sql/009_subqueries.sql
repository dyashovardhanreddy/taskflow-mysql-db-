use taskflow;

--- Users with no assigned tasks
select 
	id as user_id,
    full_name
from users 
where id not in ( select distinct assignee_id from tasks where assignee_id is not null);

--- Projects with no tasks

select 
	id as project_id,
    name as project_name
from projects
where id not in (select distinct project_id from tasks where project_id is not null);


--- Workspaces where a given user is an admin or owner

select 
	id as workspace_id,
    name as workspace_name
from workspaces
where 
	id in 
	(select workspace_id 
	from workspace_members
	where user_id = ?
	and role in ('owner', 'admin'));


--- Tasks in a workspace

select
	id as task_id,
    title,
    status,
	priority,
    project_id
from tasks
where project_id in (select id from projects where workspace_id = 2);

--- Top 3 busiest projects by number of active tasks

select 
  p.id as project_id,
  p.name as project_name,
  t.active_task_count
from (
    select 
      project_id,
      count(*) as active_task_count
    from tasks
    where status != 'done'
    group by project_id
    order by active_task_count desc
    limit 3
) t
join projects p 
  on p.id = t.project_id;
  

