use taskflow;


--- Tasks per workspace

select 
	w.id as workspace_id,
	w.name as workspace_name,
    count(distinct p.id) as total_projects,
    count(t.id) as total_tasks
from workspaces w
left join projects p 
	on w.id = p.workspace_id
left join tasks t
	on p.id = t.project_id
group by w.id, w.name;


--- Tasks per workspace

select
	u.id,
    u.full_name,
    count(t.id) as total_assigned_tasks,
    sum(case 
			when t.due_date is not null
            and t.due_date < now()
            and t.status != 'done'
            then 1 else 0 
		end) as number_of_overdue_tasks
from users u
left join tasks t
	on u.id = t.assignee_id
group by  u.id, u.full_name;


--- Project completion percentage

select 
	p.id as project_id,
    p.name as project_name,
    count(t.id) as total_tasks,
    sum(case
			when t.status is not null
			and t.status = 'done'
			then 1 else 0
			end) as completed_tasks,
	(100.0 * sum(case when t.status = 'done' then 1 else 0 end) / nullif(count(t.id), 0)) as completion_percentage
from projects p
left join tasks t
	on p.id = t.project_id
where p.workspace_id = 1
group by p.id, p.name;

--- Most overloaded user

select 
	u.id,
    u.full_name,
    sum(case
			when t.status is not null
            and t.status != 'done'
            then 1 else 0
		end) as active_task_count
from users u
left join tasks t on u.id = t.assignee_id
group by u.id,u.full_name
order by active_task_count desc
limit 1;

--- Projects with more than 3 tasks

select 
	p.id as project_id,
    p.name as project_name,
    count(t.id) as total_tasks
from projects p
left join tasks t
	on p.id = t.project_id
group by p.id, p.name
having total_tasks > 3;

--- Tasks grouped by priority
select 
	priority,
    count(id) as total_count
from tasks
group by priority
order by total_count desc;

